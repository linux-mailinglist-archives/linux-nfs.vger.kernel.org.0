Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737DF56C0E8
	for <lists+linux-nfs@lfdr.de>; Fri,  8 Jul 2022 20:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238985AbiGHQux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 8 Jul 2022 12:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238613AbiGHQuw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 8 Jul 2022 12:50:52 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA5A2E6BB
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jul 2022 09:50:51 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C16633F1AA
        for <linux-nfs@vger.kernel.org>; Fri,  8 Jul 2022 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1657299049;
        bh=/Rl5f85IF3nkDx3Pwo9LC08LxWUY/GwhOi7n6RjcOG0=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=oo2p5Q642DHn64qW3q8q/6BQxeLcydoKhTsiOq8o8cqxq0842iZywHfLGdCCxa+GK
         XaHWKTrkj14xLqXuZIVpGDniiZFqwsefPG6fP/CcSuE/s/kKrvLjTsCILw9k7hivHW
         glBg3QZwVtNpwXyDsMkpmJNCEj5/H5ZnDuyzox90AxGoKs4KAditgfAJIaGW3ACjlb
         +PlU/TK40tZj/ONgNRe3uPTFK2k4KnA74LGimvkujHvaHbev+2GttTQXnw4rxTMQTD
         kEwFv6kNMg6OvFxfmt+yuxyfLYp89QmLIce/nBxOGgUtcGsN2x4pDGYBqGioHn5hgj
         PHVfj7Apb8uOA==
Received: by mail-ed1-f70.google.com with SMTP id b7-20020a056402350700b00435bd1c4523so16461225edd.5
        for <linux-nfs@vger.kernel.org>; Fri, 08 Jul 2022 09:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/Rl5f85IF3nkDx3Pwo9LC08LxWUY/GwhOi7n6RjcOG0=;
        b=WKQtqP0TVQis8G8pWobdEXyj4CMMaT3dxRkBTyW240FKpyTeFDTxKGQ72k7LDBJC8T
         6HodzXyFmOunwbxe7EotyHU5C+hQ1sM4i2Y+fR3wwf6vkQNZMFF18CTnH8pnZpMQpVRu
         /sZXrW+UBUjTyUr+3PPdgWKNuzcuyAfmoqTC/LRx27gdko5vWc8aYltVz05MWOqTfZej
         jna79bxKm2PsyNBsEyRRfBDwkHUYMwkyREg2FfxteSREdzDbrd28d4jHSJR9AMEri+JU
         KACA+uFENh8afr4sT2fnbhcMFK8tfKC+zSln/ZobNbt5Qn8CMEZYu65ZKf1jzHzpIqHQ
         gl0Q==
X-Gm-Message-State: AJIora+4P3SAYfYb8urzWbnNhkxEBf+yayjVxCQiDmE8PcewRduodrjd
        xk7dBwe7BDYYeeW8KiDG5His3uofevYc5HXXpJdypo9Vk1I8jazp0kay6NN/q/1tfu+Yxbpdfbz
        7BufX9cwrwzki6u3KC43UTiKOSzHyXGKTNCEXgK1BfS3xpfo9BH5frA==
X-Received: by 2002:a17:907:1c09:b0:726:b834:1a21 with SMTP id nc9-20020a1709071c0900b00726b8341a21mr4398871ejc.518.1657299049397;
        Fri, 08 Jul 2022 09:50:49 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tPdfEao6ALo/9gIGJqKgeRohVRpp91FSPBWYOwWWpPNU/szvZu5EAje+bitLVFQh3FEK9Fib8qwiE1sP4Q9Ec=
X-Received: by 2002:a17:907:1c09:b0:726:b834:1a21 with SMTP id
 nc9-20020a1709071c0900b00726b8341a21mr4398854ejc.518.1657299049198; Fri, 08
 Jul 2022 09:50:49 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Fri, 8 Jul 2022 16:50:38 +0000
Message-ID: <CANYNYEFSdBua3Ay6jGk2cacossVJ8_CzDgDBnFCjXfk5XSoGEQ@mail.gmail.com>
Subject: Why keep var-lib-nfs-rpc_pipefs.mount around?
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

I was tracking down a Debian/Ubuntu bug with nfs-utils 2.6.1 where in
one case, after installing the packages, you would end up with
rpc_pipefs mounted at the same time in two locations: /run/rpc_pipefs
and /var/lib/nfs/rpc_pipefs. The /run location is what debian/ubuntu
default to.

After poking around a bit, I think I found out why that is
happening[1], but it led me to ask this question: why is
var-lib-nfs-rpc_pipefs.mount (and its corresponding rpc_pipefs.target
unit) still shipped, given that nfs-utils now has a generator?
Shouldn't the generator be enough for all cases, where rpc_pipefs is
mounted in the default compile-time location, or changed via a config
change to nfs.conf? I know currently it checks[2] whether the config
points at the default location, but that check could just be skipped
and then the generator would always produce the correct mount and
target units.


1. https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/1971935/comments/22
2. https://salsa.debian.org/kernel-team/nfs-utils/-/blob/master/systemd/rpc-pipefs-generator.c#L138
