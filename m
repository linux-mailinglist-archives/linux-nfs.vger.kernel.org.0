Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2AE575CA04
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jul 2023 16:29:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjGUO3T (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jul 2023 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjGUO3S (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 21 Jul 2023 10:29:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85ABFE68;
        Fri, 21 Jul 2023 07:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23B9161CD0;
        Fri, 21 Jul 2023 14:29:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4DA0C433C7;
        Fri, 21 Jul 2023 14:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689949756;
        bh=Ob99k3K/cvLpUD5huHKwap1tAWzVKc9is1OGALrmBu0=;
        h=From:Subject:Date:To:Cc:From;
        b=AZrO9UGHCw14XmIIsBlaAKON6cd5enNQzetcn9tg/wibmHBzA2IZOwycxsaVOFTm5
         4ekus7dN17JQt1iW7ICyi9b5nqWa1q0mqC2IXkwyFpH+Sx1nfwyOYqdTA7jtbzld0f
         0qiV5rgEBcSMkhD3DB6OcvZo9k0oGkQ6Trp//AQbS96RL8GaEHpd69oSnJnMU4UHfD
         Sh6qURMA5lWZQXJ3t3OqegZIio/wglTZ7uB5uMEyG4VHiVZMJXhvLdFmTsOP4lXLio
         ztzcQRUu8J6b8w/TfW4c5J9sYK67aDabz/xZnPSdrftVXFHkPMikXDaFT2Ak4mHRxT
         823ejTQwXonYA==
From:   Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v3 0/2] nfsd: sanely handle inabilty to fetch pre/post
 attributes
Date:   Fri, 21 Jul 2023 10:29:09 -0400
Message-Id: <20230721-bz2223560-v3-0-bb57e302bab7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWWumQC/23MQQ6CMBCF4auQWVsznVagrryHYUFhhEZDSWsal
 fTuVtYu/5eXb4PIwXGEc7VB4OSi80sJdahgmPtlYuHG0kBIChtCYT9EpE41CjPo2mDfkmwslP8
 a+OZeu3XtSs8uPn1473SSv/WfkqSQgkerDSJqZdvLncPCj6MPE3Q55y8hNA2PowAAAA==
To:     Chuck Lever <chuck.lever@oracle.com>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>, Boyang Xue <bxue@redhat.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1393; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Ob99k3K/cvLpUD5huHKwap1tAWzVKc9is1OGALrmBu0=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBkupY7dXGHou+JfJYbXGQdoDkov7ilmKJj11NEZ
 pYWrAIknlGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZLqWOwAKCRAADmhBGVaC
 FXlsD/9XQgqQsZoBuU73d8nub8b0vC9JhWBQWIB4yEScl8n2rmlLwqrsg6+cyd3v8E8FpXSiHAZ
 GvTRYtPGW/jqin8PfNLzCEYi+6BMCrxci8hlZjK3r6TqqmB8qPMDb0t++dcZUjj1ouKX32yZrX4
 dQH0TWSBIw9orUl1A4bN0Djw7GxLShy3TvUkN244kc21TMVq2/8Z7ryTIffLs5BfZeQ2xErvFX1
 hdu3922N0xh+O+1W94UtyHPJZD+q8yQSWHH8gK/Y12ZKTiSaK2ateliKoLcXl9YsCRG6nBnV+ql
 Z+5IDE+A2oMtzst49xOx9elK61PSZRHI7jY0Cij/EFdyOqblDtf/611QEjsYcwEO31h/V/g2d2U
 MpjxAkP9ULKFoRXYTGFzR9UtOVXvWtY0spHng4l6y7XmIoscwvpD8W7PEby68FaQQg2cLHh9l7D
 nLWz6CL8gSXUH4FxHBzkQfvHlDAoPMiEMFyg5hlIhFlDi4lyDmXOA9g1V67DLTVe185DMQ+/E/s
 of0FNnFCWCS7/h1g1weLgntPj2TBd4esYifLoe3W0d7aASyaLJSFzQ3cdlXxDZhzdnsFSF8W8Sv
 OghuGpO93gKoBO+cg+Y0oUawf4bIjBswMhvabjet/ldnGj/AZWW9yyMwQdd4gIX5Nm3zfpnQGCx
 w6HkX/R3oIiA5rw==
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
- rework the error paths to consistently use gotos
- add __must_check to fh_fill_pre_attrs and fh_fill_both_attrs
- fix bad error handling in setxattr codepath

---
Jeff Layton (2):
      nfsd: handle failure to collect pre/post-op attrs more sanely
      nfsd: remove unsafe BUG_ON from set_change_info

 fs/nfsd/nfs3proc.c |  4 +++-
 fs/nfsd/nfs4proc.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 fs/nfsd/nfsfh.c    | 26 ++++++++++++++++----------
 fs/nfsd/nfsfh.h    |  6 +++---
 fs/nfsd/vfs.c      | 52 +++++++++++++++++++++++++++++++++++-----------------
 fs/nfsd/xdr4.h     | 11 -----------
 6 files changed, 97 insertions(+), 48 deletions(-)
---
base-commit: c9194156c1039499533303fc63a66b0f1399896b
change-id: 20230720-bz2223560-9c4690a8217b

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>

