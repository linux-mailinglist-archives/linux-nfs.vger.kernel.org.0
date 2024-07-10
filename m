Return-Path: <linux-nfs+bounces-4777-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D792D469
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 16:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30864282589
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2024 14:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5688E193459;
	Wed, 10 Jul 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBw22DSx"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8FFE193455
	for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720622525; cv=none; b=ldxdXuXbcppX6IpxVzDONejG7g65FpAG7i72bRA7FRa4udaaOKnSZrT6JC7PQQWIK7nbPNOsc5+jsn8SaxHn50ZIamyQKRDKQ2krFXQ0uakEqgkhW26Un8FN70BSRvj/84DyGff/u28t0DWS9oEbjnRfTsHkGJlm6Mf2C8Ky62U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720622525; c=relaxed/simple;
	bh=cukCm8BkyGccbpGDtc+kP9TXAgGRa20mTIM+GaLbyCs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=n8f8D0Elgm8eI1xdkcFaFKCzws2VCXb5Y4iMVupx6xCEjF+G+mfYir8KzXD8ol3FQMPymMrTdtWzfnfMDLLZAmFKIM5SBYqsRw/mAdYWJ18faFzaZu58vwF5kot0D37jxFMSoA8lpA2pT22/8Ya0JtkwKR2bAbBfhVKycj5pwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBw22DSx; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79ef8fe0e90so345304085a.3
        for <linux-nfs@vger.kernel.org>; Wed, 10 Jul 2024 07:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720622522; x=1721227322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=OwhQ2LVMUTRuUyJt3UUSfKZuwhSM3Et154ZaHD19H/g=;
        b=RBw22DSxCFzdQh+HMKYfJgyfL0nR9bKVA9k0boo2c9vWIpSJUpui/UvLrSUkVhLWIz
         6wzQ+SnWWFnkxtxHW5g5zD1WAEwIfw3dah/UaWaqbVuG2tunvG7/FNL0JAaMP+GoPx91
         Shm+VVUUAAkFI+MWKSmvvxlMhxpxqNwfrTFNhhYZN/TkSPgzW269Hfqplgi5+KehYu41
         C3VBiH0WUQVfUGXdEv1AqhGxpPjYJu379bVyEl564enM+eczS1TqYOJFanj5ofGfqvvF
         79pPkOHz9n4jAlnYGv1Ga4r0+67o6KSYKRQRF7nIyGaK4SoPAZ1kX9EKxV8xkTtB7P9x
         PeQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720622522; x=1721227322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OwhQ2LVMUTRuUyJt3UUSfKZuwhSM3Et154ZaHD19H/g=;
        b=RxSzw8ritMpjH8v/9A9pMP8VZlLNzsS2SpINAYoyzbC3Berk97BH/ug8BoKeBnysSx
         MHRAqzAkBtzhMFio2gxX94dXN4Du3zbFBinzNfjKZRec3jBOCJczec4YuZH/8DIPor8n
         VDsfq11nc4mFtL8VKFAekf4v0WW0CQ+KEH+sZQOUZNHyXQXRLDkQLNnDXExB1q6fWFAI
         riXO+4MKcRrH4eyH9lylAM9RptY7HfhOjJ+SMVE5rpnggV/9xl+jog0M2hRbVE7NyRI/
         /PAL6RSkxlw9Rfl6CE5p37utWRouWzS9nGg3L219zxkZ+kmHAavZ2vbkquG4E/YK2X+e
         ezKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8mHG6NT9jP5r2bfx/WJX9plADSYDwLj5NRoPN2rv4Ff++8mZlngoBDFI8ai/aO/keOS/bmH6gIkY9JdV0Da8wC6rDLsKYp//e
X-Gm-Message-State: AOJu0YyXIKbVnUhntlmtGHjcSi6KmzqHc42heWrU2UEVLfjLUPOX+xyw
	f3Xl64IvP5c79VVwo4tjMuWz4cK5nb8L7v+2U7m+eMbaIIaKQ6id
X-Google-Smtp-Source: AGHT+IHnm2N4AjhrjisbIKhqIUKk/iQzYWvxJPGT9A/imaZasaY1EFeLVK16RCScLjgjOM0td1v4ww==
X-Received: by 2002:a05:620a:4ac5:b0:79f:498:2a67 with SMTP id af79cd13be357-79f19a1e5c1mr624661285a.21.1720622522527;
        Wed, 10 Jul 2024 07:42:02 -0700 (PDT)
Received: from ubuntu-dev.mathworks.com ([144.212.138.9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff82a7sm200714185a.9.2024.07.10.07.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 07:42:02 -0700 (PDT)
From: Youzhong Yang <youzhong@gmail.com>
To: jlayton@kernel.org,
	chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org,
	youzhong@gmail.com
Subject: [PATCH] nfsd: add list_head nf_gc to struct nfsd_file
Date: Wed, 10 Jul 2024 10:40:35 -0400
Message-ID: <20240710144122.61685-1-youzhong@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfsd_file_put() in one thread can race with another thread doing
garbage collection (running nfsd_file_gc() -> list_lru_walk() ->
nfsd_file_lru_cb()):

  * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file_lru_add().
  * nfsd_file_lru_add() returns true (with NFSD_FILE_REFERENCED bit set)
  * garbage collector kicks in, nfsd_file_lru_cb() clears REFERENCED bit and
    returns LRU_ROTATE.
  * garbage collector kicks in again, nfsd_file_lru_cb() now decrements nf->nf_ref
    to 0, runs nfsd_file_unhash(), removes it from the LRU and adds to the dispose
    list [list_lru_isolate_move(lru, &nf->nf_lru, head)]
  * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it tries to remove
    the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))]. The 'nf' has been added
    to the 'dispose' list by nfsd_file_lru_cb(), so nfsd_file_lru_remove(nf) simply
    treats it as part of the LRU and removes it, which leads to its removal from
    the 'dispose' list.
  * At this moment, 'nf' is unhashed with its nf_ref being 0, and not on the LRU.
    nfsd_file_put() continues its execution [if (refcount_dec_and_test(&nf->nf_ref))],
    as nf->nf_ref is already 0, nf->nf_ref is set to REFCOUNT_SATURATED, and the 'nf'
    gets no chance of being freed.

nfsd_file_put() can also race with nfsd_file_cond_queue():
  * In nfsd_file_put(), nf->nf_ref is 1, so it tries to do nfsd_file_lru_add().
  * nfsd_file_lru_add() sets REFERENCED bit and returns true.
  * Some userland application runs 'exportfs -f' or something like that, which triggers
    __nfsd_file_cache_purge() -> nfsd_file_cond_queue().
  * In nfsd_file_cond_queue(), it runs [if (!nfsd_file_unhash(nf))], unhash is done
    successfully.
  * nfsd_file_cond_queue() runs [if (!nfsd_file_get(nf))], now nf->nf_ref goes to 2.
  * nfsd_file_cond_queue() runs [if (nfsd_file_lru_remove(nf))], it succeeds.
  * nfsd_file_cond_queue() runs [if (refcount_sub_and_test(decrement, &nf->nf_ref))]
    (with "decrement" being 2), so the nf->nf_ref goes to 0, the 'nf' is added to the
    dispose list [list_add(&nf->nf_lru, dispose)]
  * nfsd_file_put() detects NFSD_FILE_HASHED bit is cleared, so it tries to remove
    the 'nf' from the LRU [if (!nfsd_file_lru_remove(nf))], although the 'nf' is not
    in the LRU, but it is linked in the 'dispose' list, nfsd_file_lru_remove() simply
    treats it as part of the LRU and removes it. This leads to its removal from
    the 'dispose' list!
  * Now nf->ref is 0, unhashed. nfsd_file_put() continues its execution and set
    nf->nf_ref to REFCOUNT_SATURATED.

As shown in the above analysis, using nf_lru for both the LRU list and dispose list
can cause the leaks. This patch adds a new list_head nf_gc in struct nfsd_file, and uses
it for the dispose list. This does not fix the nfsd_file leaking issue completely.

Signed-off-by: Youzhong Yang <youzhong@gmail.com>
---
 fs/nfsd/filecache.c | 18 ++++++++++--------
 fs/nfsd/filecache.h |  1 +
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index ad9083ca144b..22ebd7fb8639 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -216,6 +216,7 @@ nfsd_file_alloc(struct net *net, struct inode *inode, unsigned char need,
 		return NULL;
 
 	INIT_LIST_HEAD(&nf->nf_lru);
+	INIT_LIST_HEAD(&nf->nf_gc);
 	nf->nf_birthtime = ktime_get();
 	nf->nf_file = NULL;
 	nf->nf_cred = get_current_cred();
@@ -393,8 +394,8 @@ nfsd_file_dispose_list(struct list_head *dispose)
 	struct nfsd_file *nf;
 
 	while (!list_empty(dispose)) {
-		nf = list_first_entry(dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+		nf = list_first_entry(dispose, struct nfsd_file, nf_gc);
+		list_del_init(&nf->nf_gc);
 		nfsd_file_free(nf);
 	}
 }
@@ -411,12 +412,12 @@ nfsd_file_dispose_list_delayed(struct list_head *dispose)
 {
 	while(!list_empty(dispose)) {
 		struct nfsd_file *nf = list_first_entry(dispose,
-						struct nfsd_file, nf_lru);
+						struct nfsd_file, nf_gc);
 		struct nfsd_net *nn = net_generic(nf->nf_net, nfsd_net_id);
 		struct nfsd_fcache_disposal *l = nn->fcache_disposal;
 
 		spin_lock(&l->lock);
-		list_move_tail(&nf->nf_lru, &l->freeme);
+		list_move_tail(&nf->nf_gc, &l->freeme);
 		spin_unlock(&l->lock);
 		svc_wake_up(nn->nfsd_serv);
 	}
@@ -503,7 +504,8 @@ nfsd_file_lru_cb(struct list_head *item, struct list_lru_one *lru,
 
 	/* Refcount went to zero. Unhash it and queue it to the dispose list */
 	nfsd_file_unhash(nf);
-	list_lru_isolate_move(lru, &nf->nf_lru, head);
+	list_lru_isolate(lru, &nf->nf_lru);
+	list_add(&nf->nf_gc, head);
 	this_cpu_inc(nfsd_file_evictions);
 	trace_nfsd_file_gc_disposed(nf);
 	return LRU_REMOVED;
@@ -578,7 +580,7 @@ nfsd_file_cond_queue(struct nfsd_file *nf, struct list_head *dispose)
 
 	/* If refcount goes to 0, then put on the dispose list */
 	if (refcount_sub_and_test(decrement, &nf->nf_ref)) {
-		list_add(&nf->nf_lru, dispose);
+		list_add(&nf->nf_gc, dispose);
 		trace_nfsd_file_closing(nf);
 	}
 }
@@ -654,8 +656,8 @@ nfsd_file_close_inode_sync(struct inode *inode)
 
 	nfsd_file_queue_for_close(inode, &dispose);
 	while (!list_empty(&dispose)) {
-		nf = list_first_entry(&dispose, struct nfsd_file, nf_lru);
-		list_del_init(&nf->nf_lru);
+		nf = list_first_entry(&dispose, struct nfsd_file, nf_gc);
+		list_del_init(&nf->nf_gc);
 		nfsd_file_free(nf);
 	}
 }
diff --git a/fs/nfsd/filecache.h b/fs/nfsd/filecache.h
index c61884def906..3fbec24eea6c 100644
--- a/fs/nfsd/filecache.h
+++ b/fs/nfsd/filecache.h
@@ -44,6 +44,7 @@ struct nfsd_file {
 
 	struct nfsd_file_mark	*nf_mark;
 	struct list_head	nf_lru;
+	struct list_head	nf_gc;
 	struct rcu_head		nf_rcu;
 	ktime_t			nf_birthtime;
 };
-- 
2.45.2


