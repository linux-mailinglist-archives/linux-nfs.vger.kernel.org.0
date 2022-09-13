Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2061C5B65CC
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Sep 2022 04:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiIMCoF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Sep 2022 22:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIMCn4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Sep 2022 22:43:56 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5638653D22
        for <linux-nfs@vger.kernel.org>; Mon, 12 Sep 2022 19:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=COYkSMex2gzA47DKfwnMUe7xlojNBPjFMjvh/IqcQLc=; b=qCGf8Mo3phDDdaS+JlTMmoxLOX
        Lvqq3tcJBiLdfrIvFcxOMqsMfAISz6tYaC8D+Zz8KjLhM0VN3ilyngbT7lx1wLFjqP1X7KuTDdgJA
        pj2tVunnXv55X/KP7HVix479XXDBhpw9ia59loDLEgOPK1TaJqO0ZSk9l9E4zqaWMANHF8G1lRKCW
        cOcpCDEYEuG4SSC+IbSa0vQxSrqy3WzUt0qf1jUPr6929+NUxbLmaBPhtCsoB6LhIoxgivmdpJoOj
        3qYwq8kG+YXikPT5g4ulqvspSEg1cYvkOWz+Zo4cFzlKYCxlk++8bWr7FFRqjlix073/SU+XPNMvl
        M5Uuek8g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oXvti-00Fhtd-2D;
        Tue, 13 Sep 2022 02:43:38 +0000
Date:   Tue, 13 Sep 2022 03:43:38 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Benjamin Coddington <bcodding@redhat.com>
Subject: [pull request] vfs.git: fix for nfsd regression caused by iov_iter
 stuff
Message-ID: <Yx/uWom4QeQrTJz5@ZenIV>
References: <11BEA7FE-4CBC-4E5C-9B68-A0310CF1F3BE@oracle.com>
 <CAN-5tyHOugPeTsu+gBJ1tkqawyQDkfHXrO=vQ6vZTTzWJWTqGA@mail.gmail.com>
 <D0A6E504-F2C2-4A5F-BC51-FD3D88A790F0@redhat.com>
 <CAN-5tyHYH7ODzmTK=Maa3NZOSxfcE0mfaWY11+n2htQpya869g@mail.gmail.com>
 <EE9C1D1C-AA5B-48BC-9E3A-8A4523456AEE@oracle.com>
 <25AF9743-A2A2-4AFE-9123-BAD3C8F17655@redhat.com>
 <Yxz+GhK7nWKcBLcI@ZenIV>
 <8B4DBE66-960F-473C-8636-8159B397FFC0@oracle.com>
 <Yx45clPaZODzYV+z@ZenIV>
 <2F22D90A-3B64-43F0-899D-E41001DF3021@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F22D90A-3B64-43F0-899D-E41001DF3021@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git tags/pull-fixes

for you to fetch changes up to bfbfb6182ad1d7d184b16f25165faad879147f79:

  nfsd_splice_actor(): handle compound pages (2022-09-12 22:38:36 -0400)

----------------------------------------------------------------
fix for nfsd regression caused by iov_iter stuff this window

----------------------------------------------------------------
Al Viro (1):
      nfsd_splice_actor(): handle compound pages

 fs/nfsd/vfs.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
