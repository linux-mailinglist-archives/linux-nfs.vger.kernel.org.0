Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C867E4080
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Nov 2023 14:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234555AbjKGNox (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Nov 2023 08:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234345AbjKGNov (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Nov 2023 08:44:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21163C6;
        Tue,  7 Nov 2023 05:44:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C744C433CC;
        Tue,  7 Nov 2023 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699364686;
        bh=oGAuwTicPekfqewJ5UASm1lSeWTImG5/jlwpiQOtNH4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=dlXsqceIaRjkuA5IeJHu+LQu++YmsXVE3wOhks2vu6pwQW2Yuf8y3fuqcGTDezhrh
         nLIn/Wct44n580U3lOHF++guKLo57NBlrLcH+CP8dKEVLZ7TvYqaScDG5YrvoJRlcF
         QgPdHEVU+DDWMpO0z/+MCEtZHfqSGC/yF8neQyIq+b23aVDal8cEH+L4fAKBF9V1t4
         cmYfhjd0G/XQ0kFMpKXwcp70TJIBGNrkZ8IQvIBRH32uQuYnIFVy55l62OUBQvZyJX
         7fYSb8VX8Bikhd65TQJy/X1zRGf2dQSPireqCR6fcSnCtrafJhV8meTgijuZW9O2fr
         kaneABMaHl3sg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 876D6C4332F;
        Tue,  7 Nov 2023 13:44:46 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Tue, 07 Nov 2023 14:44:23 +0100
Subject: [PATCH 4/4] coda: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-jag-sysctl_remove_empty_elem_fs-v1-4-7176632fea9f@samsung.com>
References: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
In-Reply-To: <20231107-jag-sysctl_remove_empty_elem_fs-v1-0-7176632fea9f@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, willy@infradead.org,
        josh@joshtriplett.org, Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        Anton Altaparmakov <anton@tuxera.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu
Cc:     linux-cachefs@redhat.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-mm@kvack.org, linux-nfs@vger.kernel.org,
        linux-ntfs-dev@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
        fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
        codalist@coda.cs.cmu.edu, Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13-dev-86aa5
X-Developer-Signature: v=1; a=openpgp-sha256; l=826; i=j.granados@samsung.com;
 h=from:subject:message-id; bh=EW/W6zZslOuVBpUJvlaE+2AnAGMLV/WhhzCxxx+6aVM=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9MEeSJSagXc2LHP4reG5okoVcP5ennQM0zz
 fLKCMA3zM2JAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/TAAKCRC6l81St5ZB
 T+MEC/4ngnTz5jsk7DKSLQFBRxoyRmnmgQuCFEm3xLruOFhQ58fFGc3jLVQ4SRKcyMbZVYLnA/7
 92Pua+W916xF0apdkWSutPgZSVFWhE7LqCQB7OANStgZhAKgHWrkjFB8/KPiCDUTdrzG1jdHBd7
 qmw+js8kBekSLH5uC319PDTNTNRfVmu6Si2XVh4HdvnLe4xaz5yzzquq8kaZOcJEbVlPnVXBo3E
 CAy3CAkgj3SWfAzXFyi+Q3xPTvEdBH0vnOqRGR9mIcACCxTVTBlK/TyANrw989cT0ksz8sPCcvE
 MgG8c3gs8wYgbfHMjfQUURrWfZHWTUBhYBXrmma7XkJ2wabGHM5JWzXasay7RGMldjFLEAGwtTj
 Su3+/SkuiwYTpDZc5V8iLd1ewA6g1MSpAWHBJs0BBIMYPu2w52V9pE3e8/bK3QVeSs5NqBeZtYp
 qsORxK78HHwjx16fR/OQVoFLy3Nllnz0WIJoDHWKSbERarg3ey4XX+y7unPjuDW8RiLOk=
X-Developer-Key: i=j.granados@samsung.com; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for j.granados@samsung.com/default with auth_id=70
X-Original-From: Joel Granados <j.granados@samsung.com>
Reply-To: <j.granados@samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Joel Granados <j.granados@samsung.com>

This commit comes at the tail end of a greater effort to remove the
empty elements at the end of the ctl_table arrays (sentinels) which
will reduce the overall build time size of the kernel and run time
memory bloat by ~64 bytes per sentinel (further information Link :
https://lore.kernel.org/all/ZO5Yx5JFogGi%2FcBo@bombadil.infradead.org/)

Remove empty sentinel from coda_table

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/coda/sysctl.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/coda/sysctl.c b/fs/coda/sysctl.c
index a247c14aaab7..9f2d5743e2c8 100644
--- a/fs/coda/sysctl.c
+++ b/fs/coda/sysctl.c
@@ -36,7 +36,6 @@ static struct ctl_table coda_table[] = {
 		.mode		= 0600,
 		.proc_handler	= proc_dointvec
 	},
-	{}
 };
 
 void coda_sysctl_init(void)

-- 
2.30.2

