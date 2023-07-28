Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3199A767180
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Jul 2023 18:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjG1QHa (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Jul 2023 12:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjG1QH3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Jul 2023 12:07:29 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B54A3C33
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 09:07:28 -0700 (PDT)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F21E23F189
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690560446;
        bh=VWsZj46S7NjxWXV41GGxSIF0YgoDBQk8g0COLW27ZQo=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=pdY72ETqfZ7JYnKixZ5ussrueANh7sSQP4TiDe6I+Y9PzNaahTru6sZDl7D5uaJmq
         u6Izqwpw2KfR4nnIoli5tDqKDz1+6GYFdk2+EKD0jrSQUxbGl+gsirEC/CtL6D4nPZ
         PGog2fe9mIoxACLT/giwSs7z998pjR7kNwNiHs10GmeTQ068KH48rZyJPSuJBXE+M2
         wT3lp2cf8u7gp/fYBPMYs4pQJ7la4PwZStdc2NGv7/GIoJ1WM0pJwyJ83U0ITGtqk0
         PQ2Vfm5aCWTe5x3D9OPUahdp5iXctoMdSzp2DCnJNTXBfTu/0FNYM/3YpTS3j6Ba0s
         Vw22CS2nMw4kQ==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-56942442eb0so25184547b3.1
        for <linux-nfs@vger.kernel.org>; Fri, 28 Jul 2023 09:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690560446; x=1691165246;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWsZj46S7NjxWXV41GGxSIF0YgoDBQk8g0COLW27ZQo=;
        b=X2wmMnihfIs2FHwePOSylwo7ohVzulN1ViBHq8Drs5Lxp7L6slCcIE0UVIq2BZ5LQz
         VLDYb+V2UisGlX7pV7BKQLjVg3xOsOG1gZPazW3pO0vKoYnGghaPGDqtj0FO5V8B9ZvZ
         MigUzPN9UUDzf7J47rmp60DRRl6KPcAZygxh4qJxxlHbjmfSAKc6pfKEeAZpqAETaKsm
         WbPbAQ60EDSLhaDv1uPlxtb6IdvTerrUpY87IBx4zCSoO7o+ZyUzL6ON+iz1opdOGSPz
         IG7cO+u/F5lVtiAEnrS1hay0PHQRw/RYNEoXt/ysTf9EsDLOSrsK8P/74hXP9wd0StcA
         eJBA==
X-Gm-Message-State: ABy/qLbGUqHlhaMy3H+WKvoXtp9w78LBmh9ytaiUe5YBiAtmkJwSXI6Z
        sq8Vt5su0sFCIBYQZwijVPGorOJ8Fq2VwHHNPCagC0JNrpZOCaL8AOUHScB1uJddRu2z8UroAUc
        gymvP1dMmxDqBC0IhB2cDrkzys9A17tXGdAperHEveom3X6JGEY49zWpnwk9EXfu0
X-Received: by 2002:a0d:ccd0:0:b0:579:e327:8229 with SMTP id o199-20020a0dccd0000000b00579e3278229mr2025626ywd.34.1690560445873;
        Fri, 28 Jul 2023 09:07:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGIcTPbJ0h3i0ZDsy2j5KtUFu1DMFHGh9mhFYqPvPTi70yABrr5vYIIUzT14J2aE9LD/PgdOQkyxGeUmbZgz/I=
X-Received: by 2002:a0d:ccd0:0:b0:579:e327:8229 with SMTP id
 o199-20020a0dccd0000000b00579e3278229mr2025617ywd.34.1690560445631; Fri, 28
 Jul 2023 09:07:25 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Fri, 28 Jul 2023 13:07:14 -0300
Message-ID: <CANYNYEFKtw+_Y-NrOoQt9G9eund2C0=XMrXBj8mt1L=ebrSkLQ@mail.gmail.com>
Subject: [PATCH 1/2] Always run the rpc_pipefs generator
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Shipping both a static unit and a generator to mount rpc_pipefs
increases complexity and can introduce bugs, like seen in [1]. Since
there is a generator, let's use it all the time, even when the
rpc_pipefs mountpoint matches the compiled in default.

1. https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/comments/22

Signed-off-by: Andreas Hasenack <andreas.hasenack@canonical.com>
---
 systemd/rpc-pipefs-generator.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/systemd/rpc-pipefs-generator.c b/systemd/rpc-pipefs-generator.c
index 3aaeaeaf..ff6ac988 100644
--- a/systemd/rpc-pipefs-generator.c
+++ b/systemd/rpc-pipefs-generator.c
@@ -140,9 +140,6 @@ int main(int argc, char *argv[])
    s = conf_get_str("general", "pipefs-directory");
    if (!s)
        exit(0);
-   if (strlen(s) == strlen(RPC_PIPEFS_DEFAULT) &&
-           strcmp(s, RPC_PIPEFS_DEFAULT) == 0)
-       exit(0);

    if (is_non_pipefs_mountpoint(s))
        exit(1);
-- 
2.39.2
