Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991866F8EA4
	for <lists+linux-nfs@lfdr.de>; Sat,  6 May 2023 07:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjEFFHX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 6 May 2023 01:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEFFHW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 6 May 2023 01:07:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344B17695
        for <linux-nfs@vger.kernel.org>; Fri,  5 May 2023 22:07:22 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1aaff9c93a5so17203635ad.2
        for <linux-nfs@vger.kernel.org>; Fri, 05 May 2023 22:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683349641; x=1685941641;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O7nKjAz6lKmkIu4APWYOgS3N/ka2BzfnKmsZO0KbILk=;
        b=iI8qQfZow2HfTZ6B8JPcTh2K7hARi52f8XWSBQzws7uob3gV3CT8ySmWfZizTBzFI3
         hJ93qR34VVKm8AoipJXX2wWNIfdC+KKKMMA0kTd/lJyBYy+W07kgS5UPbhd7ijsuNXmm
         C3iQu22uNmHp4IWntvD1up35TjiHT/VI5EKyJH/DzApqGE5Ma17l486P36Z66iUNzKGl
         tzndBX83D9w0AOUoifcMRCmniGf4se/S7K0BX9lDO/xzE4dRpW+LuvxQfN/PrJbwDlp+
         fKxhiE2y0yt9AEoNAc71nDNZjsuDTFgZZblBUd/uLcZd9Dt8nJtcDsJ6SdO+dtWBqbI/
         bdIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683349641; x=1685941641;
        h=content-transfer-encoding:mime-version:subject:message-id:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7nKjAz6lKmkIu4APWYOgS3N/ka2BzfnKmsZO0KbILk=;
        b=iFAtzapJm8dJCfQxlE4yA6B0eki927bAgJWvZrJrInzrdqWgx4BRfhQUHLZm/qZO6N
         J95x4aq4NjxVQk45p24AtxeG7qc/Ht2Guo1rPNNykIKHBTv16hlqugF1+tnY4GpSTAtK
         9R3EeawAuBVduGq7+20IcZoqGv3gjtaQavR2FjnPfyrwFy7SEn74fKtbHHDcaKlEwrGp
         j1CgB4NSb6H7pXaoluYdBAnTk4iEYM6Q6t4CmTDFspAYH/CrmkmTdbIR3afFB4xTiujG
         1H0XgVz97QRhg5bMvBg5DT3C8fUNNpSarGWmoUtMoVpj90yqiAiZ9aSpu84F1Xbd+bza
         Vfzg==
X-Gm-Message-State: AC+VfDyPV+iIYDz6e6aOB56fKtLEcOBedtWUvIJ+cLefUsRSeNklsjg7
        Vv5cK9qCYzEuhLM+0RQCaC8R52eSLl2TYA==
X-Google-Smtp-Source: ACHHUZ7j4jcNxLdqPW/mhLgns53nYRyibFx6mq39de0mm7hNjRvEsPOSUatXSVydPgguKCAGdoKl1A==
X-Received: by 2002:a17:902:6b43:b0:1aa:ff24:f8f0 with SMTP id g3-20020a1709026b4300b001aaff24f8f0mr3286507plt.4.1683349641509;
        Fri, 05 May 2023 22:07:21 -0700 (PDT)
Received: from localhost ([49.204.162.121])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001ac2be26340sm2605880plb.222.2023.05.05.22.07.20
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 22:07:21 -0700 (PDT)
Date:   Sat, 6 May 2023 10:37:17 +0530 (GMT+05:30)
From:   jaatsix@gmail.com
To:     linux-nfs@vger.kernel.org
Message-ID: <66157547.19.1683349637802@localhost>
Subject: =?UTF-8?Q?Decision_makers_have_told_us=E2=80=A6?=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thank you for taking the time to help us out. Some organizations are tellin=
g us that the gap between technology department objectives and overall busi=
ness objectives has evaporated. Data we=E2=80=99ve gathered over the last s=
everal years has confirmed this as well.
