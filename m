Return-Path: <linux-nfs+bounces-2230-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A96874FF7
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 14:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93FACB2135F
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Mar 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C312C7F3;
	Thu,  7 Mar 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qPJOhH8P"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6912BEAC
	for <linux-nfs@vger.kernel.org>; Thu,  7 Mar 2024 13:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709818191; cv=none; b=skdR6atxpmhNh3CqurFJyXPHeCz6CP0tEmxOp3Wj/qyLSqDTtiLOVgRvDE/wjiiNvLNJan40LSqyXPHLWwEqFnWjcox9AlnhPBzpdvPK/S46xwoaRuX/N5g9GpmOrWZ9Ly4EEObK7l4fX6bYumq/z9RqlNm968SQzmyNGBrxq/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709818191; c=relaxed/simple;
	bh=Qlq77w1vqKMgkuH0NuDUUuVFkR/X/oelXEYowoNpeGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lwWv0qRH2CSiFTz4Lm9GmojgyCJ5uJ9FQGFDaupYNOZOtH1NXT7nZ4Yw/zRUJBXezY+L9Hy2aoMetZJGC++4wXqX+Npw+WA6r7qw3gHGpwfXQjgNT4cIr9Fo5VPhN2al6VlHLeuq77qo2SkM85t0h3hUHom5mjoUuvggSpnkP5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qPJOhH8P; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-413131d40f4so2356675e9.3
        for <linux-nfs@vger.kernel.org>; Thu, 07 Mar 2024 05:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709818188; x=1710422988; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IzQeaYr/ZJlq8eCil7ImZ0X3HFXIyKHZYOmUiMSv8/0=;
        b=qPJOhH8P60QmQqiIFkhS+Xn3QM+Tyy0UAjJ1WhczF8uvVeX8bSIKZsGnHBSbHkHC9d
         5jcVwvafpxe3G8kWgq4xdJE9b+gUDaNXy5gDsxDTnGEruqMHLt3sMATYyc4p5QE5qGY0
         EpzsdQvVGb4Q7VeZPH+YtOA+cCn6oFe2AZyolDwie+BG1K3KPk26PMXRkcKPRyhmcunm
         iiBx30lRfmJtXD0WVmAmOmfE31eiVWECZuheSixq2+xMX7WryMw3kw0Y5lwhH6r/eF6u
         yUDz+Ggkrna20Xk9H5kY/VZ+p/KGG2i8S6Y68PYWpr7hzasPlFc8mp5MvopOynNpSjBD
         ZCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709818188; x=1710422988;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IzQeaYr/ZJlq8eCil7ImZ0X3HFXIyKHZYOmUiMSv8/0=;
        b=Ya+jJG8hlTphPiP4iPmP6cgUIpWWJV9WLFivpkIFZWYRP96v6ClpBiJw52FGfMLSPR
         NLzCIqD8bwl5Cuwf1A8cCBCpSX1BWtW6MKqO9X7nXiar4w9s2stjgGyKjapUYMcGXuuJ
         AtWH3Vc3dre9oIF88C1lRkelp0VsdqIQU2+lfr17BF5+57RYfUhcdBbRaL3L7W8pgla1
         +oQjng5S5CgmgS/Y8d6qI+OXBCS1xaP2mr7XSRXFkOCYwXvDzU6qcVccGijXwUSLMtjl
         zPwXpQhAJrONXDAs6b5L/5jKHbGmEeavkKb1mEhJ8Yez3P0hCIszhBzWHiS/l1rR7hIP
         MQCA==
X-Gm-Message-State: AOJu0Ywpd/HdG26s4nnCaZONtDqfgQXUCxCR+qkDXnnX4fEXkW86N2ng
	NFb1Tlv4lbXJBEqxSBPBUojxSb6U0BJFxXmnwF9XOh4GWlcmyaSZfksSI6qIJ1GUv06T98nuS08
	X
X-Google-Smtp-Source: AGHT+IGQRttMYJ2BOxP9aa/C7Bu7q969LPTtkHQCQkHjwh4C3mj77X9MTifhQyjWsJYi+ZhEhJesPg==
X-Received: by 2002:a05:600c:3586:b0:412:ee8b:dead with SMTP id p6-20020a05600c358600b00412ee8bdeadmr5581114wmq.34.1709818188044;
        Thu, 07 Mar 2024 05:29:48 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c020b00b00412d68dbf75sm2650169wmi.35.2024.03.07.05.29.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 05:29:47 -0800 (PST)
Date: Thu, 7 Mar 2024 16:29:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: neilb@suse.de
Cc: linux-nfs@vger.kernel.org
Subject: [bug report] nfsd: perform all find_openstateowner_str calls in the
 one place.
Message-ID: <44e5a5f5-f8df-45bd-be1f-7d67cfb011de@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello NeilBrown,

Commit 11c3d0a15bbc ("nfsd: perform all find_openstateowner_str calls
in the one place.") from Mar 5, 2024 (linux-next), leads to the
following Smatch static checker warning:

	fs/nfsd/nfs4state.c:1674 release_openowner()
	warn: sleeping in atomic context

fs/nfsd/nfs4state.c
    1657 static void release_openowner(struct nfs4_openowner *oo)
    1658 {
    1659         struct nfs4_ol_stateid *stp;
    1660         struct nfs4_client *clp = oo->oo_owner.so_client;
    1661         struct list_head reaplist;
    1662 
    1663         INIT_LIST_HEAD(&reaplist);
    1664 
    1665         spin_lock(&clp->cl_lock);
    1666         unhash_openowner_locked(oo);
    1667         while (!list_empty(&oo->oo_owner.so_stateids)) {
    1668                 stp = list_first_entry(&oo->oo_owner.so_stateids,
    1669                                 struct nfs4_ol_stateid, st_perstateowner);
    1670                 if (unhash_open_stateid(stp, &reaplist))
    1671                         put_ol_stateid_locked(stp, &reaplist);
    1672         }
    1673         spin_unlock(&clp->cl_lock);
--> 1674         free_ol_stateid_reaplist(&reaplist);
                 ^^^^^^^^^^^^^^^^^^^^^^^^
This is a might sleep function.

    1675         release_last_closed_stateid(oo);
    1676         nfs4_put_stateowner(&oo->oo_owner);
    1677 }

The caller is find_or_alloc_open_stateowner()

fs/nfsd/nfs4state.c
  4863  find_or_alloc_open_stateowner(unsigned int strhashval, struct nfsd4_open *open,
  4864                                struct nfsd4_compound_state *cstate)
  4865  {
  4866          struct nfs4_client *clp = cstate->clp;
  4867          struct nfs4_openowner *oo, *new = NULL;
  4868  
  4869          while (1) {
  4870                  spin_lock(&clp->cl_lock);
                       ^^^^^^^^^^^^^^^^^^^^^^^^^
Huh...  This looks like the same lock that we take in
release_openowner().  Why do I not see a static checker warning for
double lock?


  4871                  oo = find_openstateowner_str(strhashval, open, clp);
  4872                  if (oo && !(oo->oo_flags & NFS4_OO_CONFIRMED)) {
  4873                          /* Replace unconfirmed owners without checking for replay. */
  4874                          release_openowner(oo);
                                ^^^^^^^^^^^^^^^^^^^^^^
Here

  4875                          oo = NULL;
  4876                  }
  4877                  if (oo) {
  4878                          spin_unlock(&clp->cl_lock);
  4879                          if (new)
  4880                                  nfs4_free_stateowner(&new->oo_owner);
  4881                          return oo;
  4882                  }
  4883                  if (new) {
  4884                          hash_openowner(new, clp, strhashval);
  4885                          spin_unlock(&clp->cl_lock);
  4886                          return new;
  4887                  }
  4888                  spin_unlock(&clp->cl_lock);



regards,
dan carpenter

