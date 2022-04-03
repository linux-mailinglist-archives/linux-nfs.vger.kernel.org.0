Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462694F06E5
	for <lists+linux-nfs@lfdr.de>; Sun,  3 Apr 2022 05:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiDCDHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 2 Apr 2022 23:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbiDCDHr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 2 Apr 2022 23:07:47 -0400
X-Greylist: delayed 331 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Apr 2022 20:05:54 PDT
Received: from mta-out-04.alice.it (mta-out-04.alice.it [217.169.118.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98E9131217
        for <linux-nfs@vger.kernel.org>; Sat,  2 Apr 2022 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alice.it; s=20211207; t=1648955154; 
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        h=Reply-To:From:To:Date:Message-ID:MIME-Version;
        b=OcOBcK2TUxDrODnB971ChDlJdSygjH4m2EU/Ip7FZQ+CvCiOHbbzRCJXpxr8i5zC63vFVowM0UGmCrR9GvLdjJTvQUr3QeNYRgCuZazUkrmZwD7U9qaeuKRPJL3dXw6vlouAvekri6P6vJrTsWGcB/E6KWxMt8ryqgkfjH/TIkk/P2cdmRzbNMTOyS/7gC5ragKFqv26dRgaJrIIK6rNOa1f/iQXDeOw0AE9nJdG3G2Lto2w+d9vnGboYVsj6VG4xY1ESk/8W1c0GIcDIHIWVRB/QHwDoOAoCZ8EnWber8bdHr4FcMjpGeabTcKEt4QEkjNjovSGFxWWeHyPDUArwQ==
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiledgiedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuvffgnffgvefqoffkvfetnffktedpqfgfvfenuceurghilhhouhhtmecufedtudenucfgmhhpthihuchsuhgsjhgvtghtucdluddtmdengfhmphhthicusghougihucdlhedtmdenucfjughrpehrhffvfffkggestddtfedttddttdenucfhrhhomhephggvuchhrghvvgcurghnuchofhhfvghruchtohcuihhnvhgvshhtuchinhcuhihouhhrucgtohhunhhtrhihuchunhguvghrucgruchjohhinhhtuchvvghnthhurhgvuchprghrthhnvghrshhhihhpuchplhgvrghsvgcurhgvphhlhicufhhorhcumhhorhgvucguvghtrghilhhsuceofhgpphgvnhhnrgesrghlihgtvgdrihhtqeenucggtffrrghtthgvrhhnpeehjeetgefhleetiedtkeelfffgjeeugeegleekueffgfegtdekkeeifedvvdffteenucfkphepudejiedrvddvjedrvdegvddrudeltdenucevlhhushhtvghrufhiiigvpeefudenucfrrghrrghmpehhvghloheprghlihgtvgdrihhtpdhinhgvthepudejiedrvddvjedrvdegvddrudeltddpmhgrihhlfhhrohhmpehfpghpvghnnhgrsegrlhhitggvrdhithdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhnfhhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-RazorGate-Vade-Verdict: clean 60
X-RazorGate-Vade-Classification: clean
Received: from alice.it (176.227.242.190) by mta-out-04.alice.it (5.8.807.04) (authenticated as f_penna@alice.it)
        id 623DC2DC00EF6C13 for linux-nfs@vger.kernel.org; Sun, 3 Apr 2022 05:00:21 +0200
Reply-To: dougfield20@inbox.lv
From:   We have an offer to invest in your country under a
         joint venture partnership please reply for more
         details <f_penna@alice.it>
To:     linux-nfs@vger.kernel.org
Date:   02 Apr 2022 20:00:20 -0700
Message-ID: <20220402200020.11013C0A17414D95@alice.it>
MIME-Version: 1.0
X-Spam-Status: Yes, score=5.7 required=5.0 tests=BAYES_50,BODY_EMPTY,
        DKIM_INVALID,DKIM_SIGNED,EMPTY_MESSAGE,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_SUBJECT,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.7 RCVD_IN_DNSWL_LOW RBL: Sender listed at https://www.dnswl.org/,
        *       low trust
        *      [217.169.118.10 listed in list.dnswl.org]
        *  0.0 RCVD_IN_MSPIKE_L4 RBL: Bad reputation (-4)
        *      [217.169.118.10 listed in bl.mailspike.net]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5089]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [f_penna[at]alice.it]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dougfield20[at]inbox.lv]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts and no
        *      Subject: text
        *  1.8 MISSING_SUBJECT Missing Subject: header
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  0.0 RCVD_IN_MSPIKE_BL Mailspike blacklisted
        *  0.0 BODY_EMPTY No body text in message
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

