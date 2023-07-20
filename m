Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC675B69D
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 20:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjGTSXf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Jul 2023 14:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGTSXe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Jul 2023 14:23:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5292736;
        Thu, 20 Jul 2023 11:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAD3461B9C;
        Thu, 20 Jul 2023 18:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CEE3C433C8;
        Thu, 20 Jul 2023 18:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689877411;
        bh=2xQwZH56W7CMb6ymICRaHKSgS+Np/hOlMyBTfdiGGG4=;
        h=From:Subject:Date:To:Cc:From;
        b=f38kPZxPdfuJ4Mhdkt+6Sl4gikjZUs4ZSxBNVWO40uyf87zMy2n9ifOfZXCYjZjL3
         0u8hJpPK3WV3dG/kq+QR5L3Z0xLIX3QC2Q4KGO2WUKErZA4ldVn2TJT0GW23wbdKeA
         E0+vnMDc+ie4vMU6TavItIff2YUVxx9qQtGPi+gHELZyYCxhY3wsLWxdPeJaCgFEr+
         HiC+9ylon4nlt+pnzgXnZf1pW1mg04GbGSt1rRKwzR/lBgyQIouIl8u6zuu9GehUQ5
         CWGZ4BFONm5WeUfG9GPlI/2oI18jv0e/V+xWsK89SPxHuQWc9CGV7OHs398y1c5bOP
         uv3StBl0lKVvQ==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v2 0/2] nfsd: sanely handle inabilty to fetch pre/post
 attributes
Date:   Thu, 20 Jul 2023 14:23:19 -0400
Message-Id: <20230720-bz2223560-v2-0-070aaf2660b7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJd7uWQC/23MQQ6CMBCF4auQWVsznVagrryHYUFhhEZDSWsal
 fTuVtYu/5eXb4PIwXGEc7VB4OSi80sJOlQwzP0ysXBjaSAkhQ2hsB8iUqcahRl0bbBvSTYWyn8
 NfHOv3bp2pWcXnz68dzrJ3/pPSVJIwaPVBhG1su3lzmHhx9GHCbqc8xc0Bu2KowAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     Boyang Xue <bxue@redhat.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1363; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=2xQwZH56W7CMb6ymICRaHKSgS+Np/hOlMyBTfdiGGG4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkuXuhrbJwqrdIEIAj6HTAlOivtz/AmSVwvewhy
 4uthc+WAxeJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLl7oQAKCRAADmhBGVaC
 FdoGD/9q7MYxED2VFsn7NXxf/hSNhtb7cY2GUKJtFHubyn5SeMoxvlSI85evdDrQ/WjvyytqkNc
 W0e7tAeid5mY4VFMv3EHG7wXyr3DOYiOtBfqAaa1YBdsTWkFG+D0vCwJknWD87QcqI3d7bHgDMM
 y8xYgrxPhGENnGAHxJqwdWf1FukDpVY70eAw1zpD7ybjElhj5LfN5JCCdlL7lUpKcioQ/oSSxZD
 bXrnT+BYzSyzVeiBeiVsAnpvVsDZZ1m8FdpLV26ZI+EQQKpnx/fB4vAht0o2dWdzK8SBWq7JlSI
 EqnvhL1gMyCqutl7L6sFk6igBAqmcIaOkYlOzr+oA116SvG/vsLwzfiSbqVON9af+ksUdY/7q9+
 MdAo6TGIGF/0qysfTxOSbU4FB0RkJpUYx9AW1dKSFxVJ9OywBOiU7tYIcTiTRGvk9iy7lPc1U+N
 8ZiQuiEzEsyqPWy9mAPcwvB+QTqqfnxrcRl7GWlliYccZsMgMLVBYU0ErqqISzyuQR5EVpmTCWY
 Hv20SmEqltWCUxU0oGvJ0IRN52URdm+Yx8/iHg/QRvcrF0bVNVo/95yMCdQZWCzXKOckOVIYvmd
 9w+Y7CFVU/63Zqkh2Rox9bmitmD0/qtdt2arWrUHDXvXIRJrYDPe3U05r7hLxmB0LsR3P1Iew5g
 7fyT+Fx9rEzhnuA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Boyang reported tripping the BUG_ON in set_change_info. While we
couldn't confirm it, one way this could happen would be for nfsd_lookup
to succeed and then for fh_fill_both_attrs to fail.

This patchset attempts to (sanely) fix this, usually by aborting the
operation if fetching the pre attributes fails. Post-op attribute fetch
handling is more difficult to deal with however since we've already done
the operation, so this has it just fudge the change_info4 if that
occurs.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
Changes in v2:
- make fh_fill_*_attrs return an error and have the callers handle it
- rework of set_change_info, to better handle missing pre/post attrs

---
Jeff Layton (2):
      nfsd: handle failure to collect pre/post-op attrs more sanely
      nfsd: remove unsafe BUG_ON from set_change_info

 fs/nfsd/nfs3proc.c |  4 +++-
 fs/nfsd/nfs4proc.c | 45 +++++++++++++++++++++++++++++++++------
 fs/nfsd/nfsfh.c    | 26 ++++++++++++++---------
 fs/nfsd/nfsfh.h    |  6 +++---
 fs/nfsd/vfs.c      | 62 ++++++++++++++++++++++++++++++++++--------------------
 fs/nfsd/xdr4.h     | 11 ----------
 6 files changed, 100 insertions(+), 54 deletions(-)
---
base-commit: 070f391ca4d48e1750ee6108eb44f751a9e9448e
change-id: 20230720-bz2223560-9c4690a8217b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

