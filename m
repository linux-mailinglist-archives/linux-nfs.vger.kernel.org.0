Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E7E7AF8D5
	for <lists+linux-nfs@lfdr.de>; Wed, 27 Sep 2023 05:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbjI0DuY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 Sep 2023 23:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjI0DsW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 Sep 2023 23:48:22 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D16C5B9D
        for <linux-nfs@vger.kernel.org>; Tue, 26 Sep 2023 19:10:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B1F1921879;
        Wed, 27 Sep 2023 02:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695780616; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6LJFYurvIBEdjZxWj6Q1GmsxiUMP/0yEOrmCGdQ4HiY=;
        b=ZYdIWpZUlFO89tlvKNP8L9PRRwL3Aao0c8/IonWvmFDhow9DBh77wD47FexeNDflpTU2Gd
        Qm8YmztDzcQvt4VSAZkJOCm2FOE+m4Q9QUG46naSlEetjjhCekBWTX9Mbk69PUCkDoC1Qx
        gFSvbIBFtOuTtLzLLqDxckLFdtimsgs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695780616;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=6LJFYurvIBEdjZxWj6Q1GmsxiUMP/0yEOrmCGdQ4HiY=;
        b=oWBCybsnze2ByHpSW6WDBtK+7+wMH4goHOYsjKSpukE3vatWul86qm3MzJRkrsz9Pw87m0
        LsSN//qeU3a0LaCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 741D61390B;
        Wed, 27 Sep 2023 02:10:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fz0KCgePE2VULQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Sep 2023 02:10:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org
Subject: help with understanding match_fsid() errors in nfs-utils
Date:   Wed, 27 Sep 2023 12:10:11 +1000
Message-id: <169578061136.5939.6687963921006986794@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


hi Trond,
 I'm trying to understand

 Commit 76c21e3f70a8 ("mountd: Check the stat() return values in match_fsid()=
")

 in nfs-utils.

 The effect of this patch is that if a 'stat' of any path in
 /etc/exports or any mountpoint below any path marked crossmnt fails
 with an error other than one of a small set, then the fsid to path
 lookup aborts without reporting anything to the kernel, so the kernel
 doesn't reply to the client and the mount attempt blocks indefinitely.

 I have seen this happen when "/" is exported crossmnt, and when a stat
 of /run/user/1000/doc returns EACCES.  This is a "fuse" mount for user
 1000, and presumably it rejects any access from any other user.

 Could you please help me understand what this patch was trying to
 achieve?  What sorts of errors were you expecting this to catch?
 Would it make sense to silently ignore the stat failure for paths that
 were found when scanning the mount table, and only take the more
 drastic action for paths explicitly listed in /etc/exports ??

Thanks,
NeilBrown

