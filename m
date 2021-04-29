Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E5936F0C4
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Apr 2021 22:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233501AbhD2UD1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Apr 2021 16:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233097AbhD2UD0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Apr 2021 16:03:26 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3BCC06138B
        for <linux-nfs@vger.kernel.org>; Thu, 29 Apr 2021 13:02:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id u3so23025677eja.12
        for <linux-nfs@vger.kernel.org>; Thu, 29 Apr 2021 13:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=nt5XzgL0gCByz6m4hNq9RfMZLQ56wIlzE2PBS0trGIi7n9nlvGtGQ08kxLkCwDnUTN
         5OwoFAZHsP12DBKbG8FtZZCvTFzU0ss+AasuXXoXOk6LaSBhkNzKNpXuKXjH+rgmMHpb
         GKiTIUZaTt+AbIcdPNZs6U8xrzDkCfkWCTb4wyjUStJ4qIV+9CXPGG0R7gDgYTosfcrr
         IuAq4GSlLnDM4WZR9Qea7lGTSms3EJ/eP8r5B9KHSmXxsiTlSCeaOg4WKgqk3mPee7Q+
         BzfV4BWaPGMgpfP2nb24B6eU6QJtpmSU+t6r2xldh/N7isvJMRYkXi9QSsCMImzPqYv3
         MNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=MK1JNYymHNZjAuSw7w569yYJuYIhIGNffTSHi9WTjH0=;
        b=OjHUOGhNC3E3YHLpHgvtNbxmXApAO2sBODK/JjZt4fnuf/2QtSlSC/F9FySZTx9mxo
         4WN1wfb94CHRncUMVGWjMTlDOyS4dLJ9WNlE0+5KFGMkik3sJ/SXa5jhsR0vh7skJTeB
         LYbQy4PPHYKDjC5E/m/lxNgHGpY6Y94uvFnmt0JvIb2vgxJNt8TiF+FBP5k+dCycfcpD
         8jgeh2raoSs/+KyuSWDJjMWkfrNIoqaqgMoLBbY6PARqNVCgVPECcdwNGB7v1NNXZeZz
         bqLb5dJGSs9SMnqJMJtRBb4uRAXV3a1OE7bJC92rDM4QQMbcVljsV7IfJem1ACqkmn/Q
         qnvA==
X-Gm-Message-State: AOAM532jHRHodLSdlhN4kXpzR0LbBu04obyIl1GzaIEqIi8ldl0UWjVh
        EBOWUxuwSEUbKxjnmr8c4hTeHp0IpwxfeCPwM0M=
X-Google-Smtp-Source: ABdhPJw3YZyWWbgaEbXMTrl6oJ0pmNquuz+5MHqfueiWA+Il/URPBhL/qZUPx2a0vw4VWXrIplD9ZN4kkDYVHulqARE=
X-Received: by 2002:a17:906:95c4:: with SMTP id n4mr185053ejy.489.1619726556741;
 Thu, 29 Apr 2021 13:02:36 -0700 (PDT)
MIME-Version: 1.0
Sender: arabi9183@gmail.com
Received: by 2002:a17:906:d967:0:0:0:0 with HTTP; Thu, 29 Apr 2021 13:02:36
 -0700 (PDT)
From:   kayla manthey <sgtmanthey1@gmail.com>
Date:   Thu, 29 Apr 2021 20:02:36 +0000
X-Google-Sender-Auth: Zhf5LbXc3-i5IA-_ycnDxw9uYG8
Message-ID: <CAGqTxMRGhBOdu-wvkQhK9zNYF0LuNU7fot0h3+nfQkcEJs4p-w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

K=C3=A9rem, szeretn=C3=A9m tudni, hogy megkapta-e az el=C5=91z=C5=91 =C3=BC=
zeneteimet.
