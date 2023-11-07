Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8737E4085
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Nov 2023 14:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234062AbjKGNoz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Nov 2023 08:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbjKGNov (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Nov 2023 08:44:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A6B94;
        Tue,  7 Nov 2023 05:44:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 936E0C4339A;
        Tue,  7 Nov 2023 13:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699364686;
        bh=Xj/qeNJ1fWTZ5t8tG8CiKkqyjuOspbgdeEVbMKEatVA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
        b=oFTJ5WLB7vlFQRcquJ5uh9QbuamVM8WKMIV/pw4Xd8rfT0VxGp+9nySvqMUfIT85k
         jeZzDs7dDrDim5hsFqidsuy7UIvV4+jJ8yJeFGlLV83K7sDhPAon3CEgZJe28WiXU/
         LCCN6o2VK85ipkpLoSjRiVG2tzpPv+FOSrsO4eRFSJoUoW7g7aTr0WMK1wrFzoVIf5
         eUzraECuGYMnOa6MdeEofoNcsrUFgxtcDEMxuGxEZdMd8h2zRy59/0RLFbWB8FzaES
         /8eIG/5UkIkvcZK0M9b80kKzZcpJGZWOqfOTinUOONpBFnwDeWlR8PZXMrAKgx/LlP
         VeXIYRw5LcYvQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 77B0FC4167B;
        Tue,  7 Nov 2023 13:44:46 +0000 (UTC)
From:   Joel Granados via B4 Relay 
        <devnull+j.granados.samsung.com@kernel.org>
Date:   Tue, 07 Nov 2023 14:44:22 +0100
Subject: [PATCH 3/4] sysctl: Remove the now superfluous sentinel elements
 from ctl_table array
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-jag-sysctl_remove_empty_elem_fs-v1-3-7176632fea9f@samsung.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1106;
 i=j.granados@samsung.com; h=from:subject:message-id;
 bh=ep6ig3KsG/haTwVjLCKKm4Kk60+leb3CQTaGMwbdTjg=;
 b=owEB7QES/pANAwAKAbqXzVK3lkFPAcsmYgBlSj9MqPIIARlpG1B3CB33QBqVpFDk5COfTwoWh
 HqFk8BAtBKJAbMEAAEKAB0WIQSuRwlXJeYxJc7LJ5C6l81St5ZBTwUCZUo/TAAKCRC6l81St5ZB
 T8o5C/9te1uxNMdDRUp6GfQqK8yJSbjVLxDs0abTPfEjp57TX/AOdFOmrwiXgdAGkwDUpVY5rKg
 qp0gHNnyXGtehooFW3SxZUwwtjPSVXxpquEnkv8gCjhenPHbGBAmOakMeL/KnhQXmtTWdZmkUDx
 iQU5SlQjl1a/Gz8IFzQ1MUTKrwEwlvA6K1ytVD+PbkS+gTi8OuUnZcIYG/2j/B+n3xMKoPjIjq2
 tda2fAiMgQpMxzcedyBjpK3EF4br8IF9NRBk+2eRARZ4TZBQbe3+d8x8c12d6nE8l1Dl6+v8XmC
 bF3irI5j7i0eA+ybQNI9qLEKv+ajjVTiVPDvndJhtvbFzP/002Ok8AvVDXnWNAfiNPPCg561Shh
 0Fa85geyCxUZXk6Kn1GwDdUYeMmie6vRU3YJtYdyrXeujBUHq5VE2iTh29hNEoI5869gs2nrZBZ
 h/Kx8YXwlg4ru1KYYeSbg04EcMK0N8fGC5qDPrdmtWsu3hksyO0KsYOGOz4r0PfP2pK9E=
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

Remove empty sentinel element from test_table and test_table_unregister.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 lib/test_sysctl.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/lib/test_sysctl.c b/lib/test_sysctl.c
index 8036aa91a1cb..9d71ec5e8a77 100644
--- a/lib/test_sysctl.c
+++ b/lib/test_sysctl.c
@@ -130,7 +130,6 @@ static struct ctl_table test_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_do_large_bitmap,
 	},
-	{ }
 };
 
 static void test_sysctl_calc_match_int_ok(void)
@@ -184,7 +183,6 @@ static struct ctl_table test_table_unregister[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_dointvec_minmax,
 	},
-	{}
 };
 
 static int test_sysctl_run_unregister_nested(void)

-- 
2.30.2

