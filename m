Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38E378F2BC
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Aug 2023 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235823AbjHaSkg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 14:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjHaSkf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 14:40:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27188E5F;
        Thu, 31 Aug 2023 11:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 929A263948;
        Thu, 31 Aug 2023 18:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F019C433C8;
        Thu, 31 Aug 2023 18:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693507232;
        bh=whvgVdcrRN9Y5YfFx0/jgRmuIMm0IZrT1yrX/bPhRT8=;
        h=From:Subject:Date:To:Cc:From;
        b=qyC98hSOvQL45pjddrHdWTXdSbanJkhPdge0aIGuDfrbKIOnlvATvJTQrNTUCFwVz
         2pmVn2G1tammhmqigSYvhdETnHBs3hMkjcwVhC8Cu0DvZCv29KL377FsS0EyVr022V
         3O+AyeAu44ioOy1dxn9dcmTSfhP8kgJYyyr8d5DUOMdG3l0hbLp36drNMMYRnIS4my
         uKpofsYqv+ILC6C28fLxHLBQRBPbuvQIYEQgjrQrxyEkl6pvVBQxLccXJVY5/4hJmy
         XqH200GiPJbjXEtv0rF34yQ4waIxBf8GNpkAQTh1FafyF4ASZ8cfKkCfIOD1zWCo6W
         /u3AWoLszYmVQ==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH fstests 0/3] generic: skip a few tests on NFS
Date:   Thu, 31 Aug 2023 14:40:27 -0400
Message-Id: <20230831-nfs-skip-v1-0-d54c1c6a9af2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJve8GQC/x3MTQqAIBBA4avIrBNK036uEi2kxhoCC0cikO6et
 Pzg8TIwRkKGUWSIeBPTGQqaSsCyu7ChpLUYVK103etGBs+SD7pkZ5VxpvUD2g5KfkX09PyrCTw
 n5MQwv+8HEuQD32MAAAA=
To:     fstests@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=781; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=whvgVdcrRN9Y5YfFx0/jgRmuIMm0IZrT1yrX/bPhRT8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBk8N6fENhHbeZaqcWcGGvvwGNdyD0Dw15BDcV3l
 SJDpAVyi4GJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZPDenwAKCRAADmhBGVaC
 FenPD/wL93BGAT6KuV1LX1LAczmE+Sf0+7ot3GARVVlRFbdrbczK5VRofrpwhyMNYZhnV7EIlK9
 wwDGSaj9tWWJYrjRqJvZpXbfOGQRwtGAD3fcoTYnJvunr0KVMCFUc/uFD2z15cbiyoUMhUGXvR+
 ulZcJR6izPAjcOTsO1qDxlnTZIKwKLyWiPYD6JZXGy4jIzqofytgDu8T1TuV4gkrYEsDWj7F7ha
 8F8RbNM/t9NDbx3X+u9fFxy/pa/wbef9luIUJMxVrC5ceev8qaBbfuWPOP3u/Pp5A24avgZClr0
 PFhqoBUVl2KSY2GoaPGWIAEUxEtmT6POW8QwST6qcdbnIw+O1j5syd2SVhlAPcKx2tFt1TMxcNn
 iNvvtcYOz4+Yy1+xsv0CabsgF3ZeoT+Hd/E29OILVMb1hW/CtZPYWA2MVceJr4Pp+U5oC+8g7mV
 qhtrd+53Wm6yvKwZktLgqmUp7GZk+jxzQmW9OhTkV9CScdj9Jb4t4ttWIcOoeBxJ2851Fp8eJaZ
 BvRSQH3Ff5gQ2tkSEqzv7gO+6jqRhRhEh88dNT7Ab+9OH/zLmjBJJL8hi2jJeMcIJJZ1jPIhIGV
 OVrCgpe4l2OQeXHn7NiOBa5OKDgHsyaKr+8mHlElj9LloIGOx+Lkq76vkph/O5fCE0S0paH9EeL
 eZNnZpcjVc+sV2Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

There are some tests in xfstests generic section that fail or are
unreliable for reasons that are known but are difficult to detect via
feature tests.

Check the FSTYP on these tests and _notrun if it's "nfs". Also add some
documenting comments as to why we skip them on NFS.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Jeff Layton (3):
      generic/294: don't run this test on NFS
      generic/357: don't run this test on NFS
      generic/187: don't run this test on NFS

 tests/generic/187 | 3 +++
 tests/generic/294 | 4 ++++
 tests/generic/357 | 5 +++++
 3 files changed, 12 insertions(+)
---
base-commit: 0ca1d4fbb2e9a492968f2951df101f24477f7991
change-id: 20230831-nfs-skip-7625a54f9e67

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

