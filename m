Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73F3278F78D
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Sep 2023 05:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348257AbjIADyJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 31 Aug 2023 23:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345733AbjIADyI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 31 Aug 2023 23:54:08 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C00E4C
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 20:54:05 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5298e43bb67so3151040a12.1
        for <linux-nfs@vger.kernel.org>; Thu, 31 Aug 2023 20:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693540444; x=1694145244; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TlCFMJcHCPgn/rFI2hFgxNBGicXq53PlWZ5OhkZWLX8=;
        b=TUSZmM6WmaI7SGlIAXiiSM2uOwKphoG8grMKSdvlIqzUfCQSNQPdWoFBqZqVGhrqPm
         kyRqy+qlbxP0cAvKcBvzhz+foQTfKx5gpGmrhTqhyoaXDwnu89yMMl5oaAj8diW84Mfw
         Wl1uuOh6S6AAsbEcTbyjlLnWWDAQPmwV4s/gkduLnEoN0upS53Gkg+itMq6WtshBqfbn
         KILq6b+mchpVgyk9CCx75KtCvyKZi6gp8n6opSyuoNtfi04OxzcdtDS9EsBoGBcTCqtm
         9h0T8h+8D4C5O7CDyR3pB81u8yJm+8Sp/suyaAKuHyfdjgjzp84itVSrw+nsfO2WQWNf
         6qyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693540444; x=1694145244;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TlCFMJcHCPgn/rFI2hFgxNBGicXq53PlWZ5OhkZWLX8=;
        b=f/zupRCgzTpRNlOpjUuNLChpQBpaJDyIWUUW4uy+6KWtFJBsMwpVMJWEw1BsXo0GpI
         WfKZK+iDYdzv4B+JW8NU2Kkn7PiziOoRITINteHBVU2yRcZZ14pWUKB93mprwYRJz53F
         Eu2oBgPOCdaZH3a/XYQadv5lDt3oR3eccA/9wZsnIKVK/6EhwvJDi7Yxg7uaPE0vemZy
         gpQDdjZn4TSCCsDrsbH96uYreNZdPP3bTn6EdDnlbxt+n3d4KCgCff3GsupNITVWATt3
         H5YRP8dFqpZObEiIoS6UY6gnnubODDXxNSiAsYmXvr6uoxJCgIQ22w7Q2Xtz4KmBgAEh
         D/sw==
X-Gm-Message-State: AOJu0Ywlx+Rg5NJ9rgTDOa2HwSVtDGxEgk0/1lvsraB3pMLufBc96BnY
        JJeTNO/2GR7Px4/huEdRvXXJ3aZWBC6HaTm6tFTDV98DrGlNGRYV
X-Google-Smtp-Source: AGHT+IH+u+ivROIm7YrZShRgtN5fKY67c4oXCZcDbOtvSZZ8aP9sW3qymgSMRkSz1kWkTcWpBhGb9LyknCLB2WI52Ek=
X-Received: by 2002:aa7:d98c:0:b0:523:b37e:b83b with SMTP id
 u12-20020aa7d98c000000b00523b37eb83bmr1645469eds.13.1693540444135; Thu, 31
 Aug 2023 20:54:04 -0700 (PDT)
MIME-Version: 1.0
From:   Cedric Blancher <cedric.blancher@gmail.com>
Date:   Fri, 1 Sep 2023 05:53:28 +0200
Message-ID: <CALXu0Ucch734JB9piCUaTbCXwuuYSTmayvSin8RFYfcYcD+FmA@mail.gmail.com>
Subject: CITI ms-nfsv41 client: IOCTL_NFS41_WRITE failed with 31 xid=5481722 opcode=NFS41_FILE_QUERY?
To:     Ms-nfs41-client-devel@lists.sourceforge.net,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

The CITI ms-nfsv41 client for Windows sometimes prints the following warnings:

1eac: IOCTL_NFS41_WRITE failed with 31 xid=5481722 opcode=NFS41_FILE_QUERY

Does anyone know what this means? Data loss?

Ced
-- 
Cedric Blancher <cedric.blancher@gmail.com>
[https://plus.google.com/u/0/+CedricBlancher/]
Institute Pasteur
