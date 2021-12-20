Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60DAA47B2E4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Dec 2021 19:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbhLTSeB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Dec 2021 13:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240365AbhLTSeA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Dec 2021 13:34:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA85C06173E
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 10:34:00 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so509371wme.4
        for <linux-nfs@vger.kernel.org>; Mon, 20 Dec 2021 10:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=IDrVy9T0fig+zHXcl/v7eeKHyLwe57nRQyXVBI7ekg95BHJf2T4dexcZRrdAyCDni9
         3LWP1xhWndLyVIppLzIJtznI1VyPZH2aquK1k9w94FK54SqPcKyJ9bR5hw94XF9XuRlz
         Mcsr9cH7BYUOw7e5yX6deosOAomcmFlDc7e3llo6sq1qUB0KwiMuPQ3fm7GWLes8X100
         w44YqZFgf+r/XO2Sd5+t82m9sfabJ6G6N/Ip2DYauBCL9FO7T4rBl6f9/UZdX4eHyT+j
         1il5MgCa1Cbqjknx2fqYzkfyCMZC5n05slrKl0RtBhHBpBtjMB20I78v/ToQ8LztWS7l
         vKNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=UtoF0r4yG8U/T8UOLxn8dacSd49m7zi2Qvhr7fGOaoo=;
        b=zj+tMVBYaah/N4H7GfsbB+/Q83aLIurGyFSbvlTBHZi9+9KWeUgJ0kItkwKVu5VgyX
         sKymM8bxUTIesRAwKAzn6k55+BJIzGzkjFmPrupVZ9FPido5LswvCFHPJemm1ZHKLf6N
         XG3xvGB6JkcrtiJyGWD+3eubInyedPduN+Fcybh4BYW3DowvNMV5K2/durCM8ye08e4m
         66XeqTEq8fOt8X+BdETzlisx7/bWisDt/dNc21sgWS81OGrioevtk/O+peZCeirotve8
         Tat0fIIz5mtiweejg9qJyopP/5v4ASnIJogihtnzcZcghPXPyDnJ3wJZe4/vbYabZWXd
         09WQ==
X-Gm-Message-State: AOAM533Rp2DDDZqQJalyCxtIEtAZZujp4jh2r25AYGE+AnbEY+NE0QS3
        C+ylaTTrz/YByGGo5MwVOjo=
X-Google-Smtp-Source: ABdhPJzOp4CIYop0S7ZB3+G0/tpgUNcSPdei2RzUSknBrIo/tZJPbkoWjhtN263jyGlK30gApVre1Q==
X-Received: by 2002:a1c:ac46:: with SMTP id v67mr223476wme.182.1640025239144;
        Mon, 20 Dec 2021 10:33:59 -0800 (PST)
Received: from [192.168.9.102] ([129.205.112.56])
        by smtp.gmail.com with ESMTPSA id i9sm14455869wrb.84.2021.12.20.10.33.54
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 20 Dec 2021 10:33:58 -0800 (PST)
Message-ID: <61c0cc96.1c69fb81.58d21.9166@mx.google.com>
From:   Margaret Leung KO May-y <kshirsha16@gmail.com>
X-Google-Original-From: Margaret Leung KO May-y
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: =?utf-8?q?Gesch=C3=A4ftsvorschlag?=
To:     Recipients <Margaret@vger.kernel.org>
Date:   Mon, 20 Dec 2021 19:33:51 +0100
Reply-To: la67737777@gmail.com
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bin Frau Margaret Leung Ich habe einen Gesch=E4ftsvorschlag f=FCr Sie, erre=
ichen Sie mich unter: la67737777@gmail.com

Margaret Leung
Managing Director of Chong Hing Bank
