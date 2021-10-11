Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD82142E421
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Oct 2021 00:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbhJNWaV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Oct 2021 18:30:21 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:42856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbhJNWaU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Oct 2021 18:30:20 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 8EEC921A72;
        Thu, 14 Oct 2021 22:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1634250494; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUFL3ZLGPm0rWVZLWnRAj8hRPQ4ZV05W4Un+rW6T6io=;
        b=PchXP96AsDXWfThRfYutw0VLLgHywxPa5D33oJCwcd7Z2ClFl3BETX3g8tcEIxQWj3GBUi
        GtSIU29aa0NiCfBIqpwv2t/JxEZjAab+jC0bah6vE9YvZJZFOaMW63Dd00kNrsATcXLnw1
        zvTKn1azyjrPSIp3GKL/YdTQUn7uHEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1634250494;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUFL3ZLGPm0rWVZLWnRAj8hRPQ4ZV05W4Un+rW6T6io=;
        b=skP2MspvCNtFDeI9MSDhoQrHyAFp2kiXrfBWNSNLmQCe92zlGBxtqSlwM3qw1e6u2Mdton
        m8fjV3Hqpzn8f5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3D4F513B3A;
        Thu, 14 Oct 2021 22:28:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id M2i2NvuuaGHiPAAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 14 Oct 2021 22:28:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Bruce Fields" <bfields@fieldses.org>,
        "Scott Mayhew" <smayhew@redhat.com>,
        "Timothy Pearson" <tpearson@raptorengineering.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Trond Myklebust" <trondmy@gmail.com>
Subject: Re: CPU stall, eventual host hang with BTRFS + NFS under heavy load
In-reply-to: <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>
References: <281642234.3818.1625478269194.JavaMail.zimbra@raptorengineeringinc.com>,
 <162855621114.22632.14151019687856585770@noble.neil.brown.name>,
 <20210812144428.GA9536@fieldses.org>,
 <162880418532.15074.7140645794203395299@noble.neil.brown.name>,
 <YWCpnsdVqssFaLrf@aion.usersys.redhat.com>,
 <589AFA4F-DF8E-45A3-8299-54E820E33169@oracle.com>,
 <20211011143028.GB22387@fieldses.org>,
 <34A4C7EB-2798-4482-A786-90161F5F9E34@oracle.com>
Date:   Tue, 12 Oct 2021 08:57:47 +1100
Message-id: <163398946770.17149.14605560717849885454@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 12 Oct 2021, Chuck Lever III wrote:
> 
> Scott seems well positioned to identify a reproducer. Maybe we
> can give him some likely candidates for possible bugs to explore
> first.

Has this patch been tried?

NeilBrown


diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index c045f63d11fa..308f5961cb78 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -814,6 +814,7 @@ rpc_reset_task_statistics(struct rpc_task *task)
 {
 	task->tk_timeouts = 0;
 	task->tk_flags &= ~(RPC_CALL_MAJORSEEN|RPC_TASK_SENT);
+	clear_bit(RPC_TASK_SIGNALLED, &task->tk_runstate);
 	rpc_init_task_statistics(task);
 }
 
