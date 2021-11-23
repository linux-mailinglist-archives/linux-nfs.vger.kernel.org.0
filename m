Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46C284599BE
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Nov 2021 02:31:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbhKWBeN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Nov 2021 20:34:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37070 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbhKWBeM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 22 Nov 2021 20:34:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B439A1FD33;
        Tue, 23 Nov 2021 01:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637631064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0bVY7Da7DZBKUJ4QKP/kjBakF12BS7ZR80Gf4eVuL8=;
        b=2BqNsQ03qAER6VnwiW83yTocuZ/fqbHQUTfBcg281fkIqvGkyYd0NIFwONDjQ8I9iahkRP
        gU7gGxJxv2WBKxJfxdTvcj2O/JsqFSiDImGWAThPUn0hScbVXqRbNxHln5nxX3MOA33a3J
        +SSZCkfBD5/drHHCU7vl+Knt3aUbSh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637631064;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a0bVY7Da7DZBKUJ4QKP/kjBakF12BS7ZR80Gf4eVuL8=;
        b=G63oLxiIbbwygXdeUwnRIXU2vgwh8YwdqI0pCHXPWDxefs/vYkRSFfbKBNE6BWkpdECCO5
        22ucAKtbxEo3emAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A054213BD4;
        Tue, 23 Nov 2021 01:31:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ai5pF1dEnGGwcwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 23 Nov 2021 01:31:03 +0000
Subject: [PATCH 02/19] NFSD: handle error better in write_ports_addfd()
From:   NeilBrown <neilb@suse.de>
To:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 23 Nov 2021 12:29:35 +1100
Message-ID: <163763097543.7284.12067402792054742606.stgit@noble.brown>
In-Reply-To: <163763078330.7284.10141477742275086758.stgit@noble.brown>
References: <163763078330.7284.10141477742275086758.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If write_ports_add() fails, we shouldn't destroy the serv, unless we had
only just created it.  So if there are any permanent sockets already
attached, leave the serv in place.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfsctl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 5eb564e58a9b..93d417871302 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -742,7 +742,7 @@ static ssize_t __write_ports_addfd(char *buf, struct net *net, const struct cred
 		return err;
 
 	err = svc_addsock(nn->nfsd_serv, fd, buf, SIMPLE_TRANSACTION_LIMIT, cred);
-	if (err < 0) {
+	if (err < 0 && list_empty(&nn->nfsd_serv->sv_permsocks)) {
 		nfsd_put(net);
 		return err;
 	}


