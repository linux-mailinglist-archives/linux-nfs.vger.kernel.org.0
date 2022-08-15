Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE205931CB
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Aug 2022 17:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbiHOPbI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Aug 2022 11:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiHOPbG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Aug 2022 11:31:06 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 057936578
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 08:31:06 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id tl27so14141527ejc.1
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc;
        bh=VUY5kDmR9824W1xBk14XxSvJCM0WwmjsFK95MEw3090=;
        b=R2mu5jtzARQVN3Cpobt8B4kovytSM+7bVT2RAjVNfDUzR+4eLAjqiONeQ5RhqczRNa
         mYofHYZGJj7lnhr60oq4pAput+9OhFWUY1JPCho+/FSHIZLdb6c1rpBn8+9HdGeC22u6
         xHGZWOpdZqlJmdIxh+U4CM3HGHfhwiwDP7bxwiiGiAldW00lQSHK1aE1a2UF+q6QRpYa
         eOYKdVqcWBbsbngUjdbjYmss9kUM5YlwSVTrbaOqZRRJvixVVhOulCX5LreorkoQElTh
         MFxzqeHP8OwQ70spYERSyA7RJt+Bzrf8Qsz33tfT8FWLRsdIC+FXtiUhxNa52VRfT20z
         Vpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VUY5kDmR9824W1xBk14XxSvJCM0WwmjsFK95MEw3090=;
        b=Y3ol1J1EU9OxvJAuIjl0A1vXil/Qa/jTSA9dXCFCna4IT+vEsYIpk1sX2wIaTFvWx9
         LNLduuxRqtusAajtTMQu8ElsOL+wVviVjmqSMycLfvew6DCzdzt/s9VHxf7JeaVgFlkS
         rl/LpwlxDMwajOaHw9q56TpgPJsmhLHL96vfqAv3HFzB9OCmma0a6q4NAJzZNYFu1xpt
         S4zS5Q7IDS1BQJ66hIn+IA445HNqOGyU0Ba8y0zkmDssVphNl3OZENrqVBbjZnTEe2dY
         Y7OkkIjclklSCWvRxRwJhmYQCe+BmEpQGRbqDcyfpk3G6BBfaPSisitzXY6rYqPlcT6l
         hg1A==
X-Gm-Message-State: ACgBeo0Tay9L6AAcdjm4iyKSc7T2pN5PzYVzCcP4sbZMdYUSYn7OBn/a
        MLXnk/najJxZ9TDHgqAZtt/lzgzfUwKJ8mLTIdln14YfXWNiGQ==
X-Google-Smtp-Source: AA6agR59CyxSbeeHvnJYBi+pvKw+2sL7RiENRNSDa8gwnVXqAtEpGYHL8K4Qb8DXPuIF4Ly83gICYx6E7Vz/YnBMRVc=
X-Received: by 2002:a17:906:216:b0:711:f623:8bb0 with SMTP id
 22-20020a170906021600b00711f6238bb0mr11127237ejd.174.1660577464337; Mon, 15
 Aug 2022 08:31:04 -0700 (PDT)
MIME-Version: 1.0
From:   Lukasz Jurewicz <lukasz.jurewicz@gmail.com>
Date:   Mon, 15 Aug 2022 17:30:28 +0200
Message-ID: <CANfUGLZaPsxk+Ko-GWKe1=Q_aKVSPd8HEGO4kpRWYmOEbKrUXA@mail.gmail.com>
Subject: NFS ver 4.2 performance drops down to 20MB/s
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi

I believe that i have found an issue with the nfs version 4.2 client side c=
ode.

I notice that sometimes read performance over nfs (using tcp protocol)
drops down to 20MB/s

To bring performance back to normal in this case (5GB/s) I have to
manually remount the nfs share.

After investigations I believe I that the issue is related to
reconnect after a connection failure.

I have found an easy way to reproduce the problem:
  1.      Start a simple read io test using for example =E2=80=98fio=E2=80=
=99
  2.      Pull out the network cable
  3.      Wait a few seconds
  4.      Reinsert the network cable to restore connection

The NFS client will reestablish the connection, however the speed
recovers only up to 20MB/s. Before cable pull it was 5 GB/s.  Leaving
the connection for X time does not change the speed, only stopping IO
and remounting restores performance.

I can see this issue on the latest Ubuntu 22.04 kernels and also clean
vanilla kernel =E2=80=93 5.19.1.

NFS server side is using Ubuntu 20.04.4.

NFS client is connected directly to server (no switch). Network
devices are Mellanox ConnectX-5 cards in ethernet mode.

I have also tried the MOFED drivers (latest version 5.7.1) and no luck
in case this OFED related.

Is this known problem? Or any advice would be appreciated.
I can supply logs / debug should this we required

Thank you
Lukasz
