Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DF15FCCF1
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Oct 2022 23:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJLVSw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Oct 2022 17:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiJLVSo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Oct 2022 17:18:44 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEF211877B
        for <linux-nfs@vger.kernel.org>; Wed, 12 Oct 2022 14:18:43 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C7E5120CA8;
        Wed, 12 Oct 2022 21:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665609521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cdKD9Lozob1RAMDq3dO22DM9KeuLQPZJy7dHFq+GoE=;
        b=kjv2vfCQfubuK+QJx/cNOwhbn++a8UQaciNwP9vbMQTMOjzIO7TBthlRW3rcS1GUvU7myc
        /cFkOPUMEcwXDZot2jgu2Pp4BxnrlhzggFkZM/l78u/4qeTGoMPQgm99Jt1fadKkSmLnhA
        +cJvD0E+hNPZW+ydjqcPuM2gmWR3wt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665609521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6cdKD9Lozob1RAMDq3dO22DM9KeuLQPZJy7dHFq+GoE=;
        b=CxebmIuDHRyua01yGzhX4BgRzXSj5bKMpDlYxy6ni3H/fq24IKx4K1Yr45CteorqLpOvy8
        oS2mKoQxERUkMaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C425813ACD;
        Wed, 12 Oct 2022 21:18:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ImIlHDAvR2POdQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 12 Oct 2022 21:18:40 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 7/9] NFSD: Use rhashtable for managing nfs4_file objects
In-reply-to: <4004BFE1-C887-4A53-9512-8A264E0361FF@oracle.com>
References: <166507275951.1802.13184584115155050247.stgit@manet.1015granger.net>,
 <166507324882.1802.884870684212914640.stgit@manet.1015granger.net>,
 <166544739751.14457.9018300177489236723@noble.neil.brown.name>,
 <EB08B095-BF02-4B5E-8CD2-12B0201328D2@oracle.com>,
 <166553144435.32740.14940127200777208215@noble.neil.brown.name>,
 <4004BFE1-C887-4A53-9512-8A264E0361FF@oracle.com>
Date:   Thu, 13 Oct 2022 08:18:36 +1100
Message-id: <166560951668.32740.3528791072339550207@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 13 Oct 2022, Chuck Lever III wrote:
> 
> I think I stopped at the non-list variant of rhashtable because
> using rhl was more complex, and the non-list variant seemed to
> work fine. There's no architectural reason either file_hashtbl
> or the filecache must use the non-list variant.
> 
> In any event, it's worth taking the trouble now to change the
> nfs4_file implementation proposed here as you suggest.

If you like you could leave it as-is for now and I can provide a patch
to convert to rhl-tables later (won't be until late October).
There is one thing I would need to understand though: why are the
nfsd_files per-filehandle instead of per-inode?  There is probably a
good reason, but I cannot think of one.

Thanks,
NeilBrown
