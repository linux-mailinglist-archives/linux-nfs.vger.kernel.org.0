Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB8CE7E9F37
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 15:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjKMOx0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 09:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjKMOxY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 09:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A6210E5
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 06:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699887156;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=JUpBKUtT2ME2uNhQIxV9UbEOJ0EfH3BsEvFe7UvqMno=;
        b=Achz3wQxVsBYgJKEQpnAwvFjkEx9uKCCTVpqvqShNLSt2XyW7Kblxnly4bXe+D/r4DnYUY
        t8DGWg8sEI4VUVYknPVDTC2Erx2eJIKZNiadbx9QVTlg1swT4pusMtcjFGFCmWa7YqURBq
        WlqmvuHPmJXnh6KHY5KRlbrLDFJXQjQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-_tVt1mlXNlaPI_daFPcetA-1; Mon, 13 Nov 2023 09:52:35 -0500
X-MC-Unique: _tVt1mlXNlaPI_daFPcetA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-53fa5cd4480so3023073a12.0
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 06:52:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699887153; x=1700491953;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JUpBKUtT2ME2uNhQIxV9UbEOJ0EfH3BsEvFe7UvqMno=;
        b=qz+IfxFeI/PLA5ZClv8s8IZGj5v2dsTRcgf4yi6ykskWdgfV+2u9gDh66SjBTV8KuJ
         9KAgBlh3tw0ZcQpne4iU4CZYlUIauU6UJtDzg3ocURD4ejZT29n99+n3PQe76d0FGjoX
         +9aDpbiZJfJSFKwmUBHHGhH0NfYWBldiImFpiMXlF3oJ1iY6kl60OtnMkpfRyyR2SdoQ
         Tvn6fsQxqECJknDyTjSumIVFdIIT0sPcggcCBNx41hmTiAShRmLWCVjibMAxnF8O5iPG
         pSZxX6Zuo4+N5DXE5khxIhLB4B9UChf3HFqiItk0POj60VYaHnLJv6yLccGdqSUI+l2k
         aGyA==
X-Gm-Message-State: AOJu0Yymtut7WHIa0OoRwEEjKTYJsaaJaSEt/M2qcmGC7OHzLjmfRlIF
        +BwD5o9KWOrq5vACxePdCGVhKDhEFlqgUicc25GWG9A2U119j4hCW+OwOQotEpCH051vyyHqLAs
        mYdbPL1XPUGMRDy4xhSem1DJO6HtXWQhrw7WB1FdfQuSaaAc=
X-Received: by 2002:a17:906:3c9:b0:9e6:59d5:7a86 with SMTP id c9-20020a17090603c900b009e659d57a86mr4289125eja.57.1699887153586;
        Mon, 13 Nov 2023 06:52:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJhzXRJr0tTp5Ok7+R8Dvhf+y1h1kgUT6VerZ9DKbjEdUAx3lYZBFfNzYB2nSkgxp+XJO2t88vbRXKtWUXMEI=
X-Received: by 2002:a17:906:3c9:b0:9e6:59d5:7a86 with SMTP id
 c9-20020a17090603c900b009e659d57a86mr4289116eja.57.1699887153356; Mon, 13 Nov
 2023 06:52:33 -0800 (PST)
MIME-Version: 1.0
From:   Alexander Aring <aahringo@redhat.com>
Date:   Mon, 13 Nov 2023 09:52:22 -0500
Message-ID: <CAK-6q+iiPxnBwWGhHPqPoNQ2Gahc2QvNFLDw7siEtVjKo98g6g@mail.gmail.com>
Subject: nfs4_renew_state hogged CPU ... consider switching to WQ_UNBOUND
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi nfs people,

I use in my "fragile" kernel hacking development setup a nfsroot
setup. I accidently turned on the kernel config
CONFIG_WQ_CPU_INTENSIVE_REPORT. Now, sometimes I get:

workqueue: nfs4_renew_state hogged CPU for >10000us 16 times, consider
switching to WQ_UNBOUND

and I just want to drop this mail so that nfs people are aware of
this. I am not sure if nfs4_renew_state can be easily switched to
WQ_UNBOUND and it really makes sense to do it.

I also don't do any specific workload on nfs, as I mentioned I use it
for nfsroot and I get several of those messages over time. I used nfs
version 4.0 and those messages showed up. Jeff told me to switch to
4.2 and try it again, but I still get those messages.

So here is my mail to start some kind of discussion about it. :)

Thanks.

- Alex

