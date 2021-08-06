Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C50F3E2BE1
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Aug 2021 15:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhHFNsK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Aug 2021 09:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41697 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229862AbhHFNsJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Aug 2021 09:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628257672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
        b=b2Jci/h4hbAM6zFebrv5yJunQ/2bK+vh9PuUabQ3RwlUZQjqsVfZ2lrqAlACl1WwdTIz1K
        D37ZFSp78hlj/RCcGNF69g6suMuhYfq6AurjXSoMIQb/8xrudp+cASM23+nrdXSsiXxdzc
        k0hqDauBeaq5Bea1JkEv5tGf89c2POc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-xwATVGxAORKS_qL9QW3a3A-1; Fri, 06 Aug 2021 09:47:51 -0400
X-MC-Unique: xwATVGxAORKS_qL9QW3a3A-1
Received: by mail-wr1-f72.google.com with SMTP id p2-20020a5d48c20000b0290150e4a5e7e0so3137271wrs.13
        for <linux-nfs@vger.kernel.org>; Fri, 06 Aug 2021 06:47:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyKrp7I82f3wYzsbQR/1Jeu1cFgJoa6hSbBVeuarAhw=;
        b=Ypz69MSTIFbO4EvrlrIGf6g5jbYIPj3bF5s7ZnMm6cZcYx+Evxbys4Wm5sa1VwntJx
         y6pPlwBRuii2IT25KtREDyY0Do/yYrYEXGBmEX37LBapzC4/WW/XMysGqzNE8SD1ZduF
         /FwmlY0hiDrrsVAygBNqUhjjvYceAxShG0FBtsHBPl0RFF/1JXJwOdo+SpTIHJt+6yoV
         /hpYa1YnlhbsycZQ0qVLHrLgdffR9nPMIgwj4rRyexDHtI2BUSjSiDm2GmdJnLDQ645y
         YZca6GS2qtNVD8o48y71MUjkNjYGAoLQi83ItYX7mabZ/2vpFI69vmyJdFuqiZQAgmRQ
         sx3Q==
X-Gm-Message-State: AOAM530bTNt0YFMFEYMOsY0MrxyYw8VjuAvsmcAL22jTXPrHXxZF5/d0
        GWvjR5p64lYm95ZInN+dku75o0NQmdmY22cUqrNvHlwohdE9pv3lWRNwxtTg9Ya4Poe42nja/Nv
        MnRCFtxmaCZ/gywjMjuHQrEMCRbfvK9VPY5yMpDUe2V9UCn+2nqljSiquTk+XEmx+jmHtGls/7V
        8=
X-Received: by 2002:a1c:7419:: with SMTP id p25mr20026656wmc.160.1628257670744;
        Fri, 06 Aug 2021 06:47:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwSKBpoKbeevC2m8QlqjM9kdLjf5rpRqEoJu5fcWQPGYWa7T0DJ+XEub0K0VotW0Tt8qBjE6Q==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr20026639wmc.160.1628257670529;
        Fri, 06 Aug 2021 06:47:50 -0700 (PDT)
Received: from ajmitchell.remote.csb ([95.145.245.173])
        by smtp.gmail.com with ESMTPSA id i29sm8847731wmb.20.2021.08.06.06.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 06:47:50 -0700 (PDT)
Message-ID: <d812b290c1cdee5320b811f0329e5c1d4b1c1931.camel@redhat.com>
Subject: [PATCH 3/4] nfs-utils: Fix mem leaks in krb5_util
From:   Alice Mitchell <ajmitchell@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>
Date:   Fri, 06 Aug 2021 14:47:48 +0100
In-Reply-To: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
References: <ee45aa412acaf7a2c035ad98e966394a7293dd9f.camel@redhat.com>
Content-Type: text/plain
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

DQo=


