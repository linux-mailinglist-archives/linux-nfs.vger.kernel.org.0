Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC2F17B991
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Mar 2020 10:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgCFJu0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Mar 2020 04:50:26 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:39728 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFJu0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 6 Mar 2020 04:50:26 -0500
Received: by mail-il1-f196.google.com with SMTP id q87so1216233ill.6
        for <linux-nfs@vger.kernel.org>; Fri, 06 Mar 2020 01:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=/P9ncvx+VEUMrpqNZpinMs8EiuqcVr5r7uKIGRLhXTM=;
        b=hve1laRBE/DppOS8DhSeyPWweRiWj7u0qnQkyfb5WiqvT4YCwOweCMDDDkeYaxKUCv
         7N3sFZlF+74n86w7uUvknLaSKvH8SJ+m1mMbzypLLM+661zgubiAMQmOleSkKQbvkzyS
         k2iMuhNg1sSiqP3PvKT/WdrwJa8vQOZglMgh56L4jlRVcgMAu711WgBeiBkJ+CDd2hTX
         vsLXzwzFwU8X7549AQ+IVV6PQBGwYkIthlPV6hqHcwguWfktGfz80EfD6Vnui+BYQQM5
         Y1gOXRjmNrgQQVG/PRoGf5lqXdwXishlCwC/yL9xjduXu3VvH6D0fbrNsKH3Egg1zap6
         aHtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=/P9ncvx+VEUMrpqNZpinMs8EiuqcVr5r7uKIGRLhXTM=;
        b=lOmo4GYDYvoZa1Qm/1QoYQfHfHlaAS/SH6nzgYee1GaQc4iGiPHfyqVnR00wGAl51o
         oiPMIH01SMavEvfdTDew3s+45scbBTTqPJkuNRbX/0qOOW9lv14tyTb48Yss+PQ5TQZ7
         VN4m+dzEksFVnIcQXpAzf0ezr1W/U91VhDwlJz8NOZYikp22TPdaH7pzbi2grgQt1Cm0
         hhGoilm1j850AxvgXOn158smsJr7rm0mtkknoNvn4bZG0KuWeGtUO07oxidf28i+KKRr
         iMW8h85UqKMjZ9A1Warg70TmZtbdAT9XXAiUiGxjBYWP9wyYZ01QIokRf3hHudASCrGR
         17Ig==
X-Gm-Message-State: ANhLgQ3CCeFdFbF/m4xl7ivYqRxj9GaLOoP0vYnD3cHPUTM6WUZfAHLw
        Ia7g9GgdbrT1NMcLKT3uSbhirnV+Y1Je8ONFBog=
X-Google-Smtp-Source: ADFU+vsXXojjv/j/yVJ6zkLa7W1BGo2TRBT0tvBGUm/XVPwlVxIc4LIc4HWKpg6rqxAqUgQ/FIWNAsXi0FHqHC8izP0=
X-Received: by 2002:a92:c106:: with SMTP id p6mr2261951ile.95.1583488225734;
 Fri, 06 Mar 2020 01:50:25 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:1344:0:0:0:0:0 with HTTP; Fri, 6 Mar 2020 01:50:24 -0800 (PST)
Reply-To: robertandersongood1@gmail.com
From:   robert <robertandersongood20@gmail.com>
Date:   Fri, 6 Mar 2020 01:50:24 -0800
Message-ID: <CAEC7LWGEv5XshsKRfe-a5dnnm-SFD3c6H8XVwQwD_QP7QPkYmg@mail.gmail.com>
Subject: help
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsDQrQnNC10L3RjyDQt9C+0LLRg9GCINCR0LDRgNGA0L7Q
sdC10YDRgiDQkNC90LTQtdGA0YHQvtC9LiDQryDQsNC00LLQvtC60LDRgiDQuCDRh9Cw0YHRgtC9
0YvQuQ0K0LzQtdC90LXQtNC20LXRgCDQv9C+INGA0LDQsdC+0YLQtSDRgSDQutC70LjQtdC90YLQ
sNC80Lgg0L/QvtC60L7QudC90L7QvNGDINC60LvQuNC10L3RgtGDLiDQkiAyMDE1INCz0L7QtNGD
INC80L7QuQ0K0LrQu9C40LXQvdGCINC/0L4g0LjQvNC10L3QuA0K0JzQuNGB0YLQtdGAINCa0LDR
gNC70L7RgSwg0YHQutC+0L3Rh9Cw0LvRgdGPLCDQv9GA0LjRh9C40L3QsCwg0L/QviDQutC+0YLQ
vtGA0L7QuSDRjyDRgdCy0Y/Qt9Cw0LvRgdGPINGBINCy0LDQvNC4LCDQv9C+0YLQvtC80YMg0YfR
gtC+INCy0YsNCtC90L7RgdC40YLQtSDRgtGDINC20LUg0YTQsNC80LjQu9C40Y4g0YEg0YPQvNC1
0YDRiNC40LwsINC4INGPINC80L7Qs9GDINC/0YDQtdC00YHRgtCw0LLQuNGC0Ywg0LLQsNGBINC6
0LDQug0K0LHQtdC90LXRhNC40YbQuNCw0YDQsCDQuCDQsdC70LjQttCw0LnRiNC40YUg0YDQvtC0
0YHRgtCy0LXQvdC90LjQutC+0LIg0LIg0LzQvtC4INGB0YDQtdC00YHRgtCy0LAg0L/QvtC60L7Q
udC90L7Qs9C+DQrQutC70LjQtdC90YLQsCwg0YLQviDQstGLINCx0YPQtNC10YLQtQ0K0YHRgtC+
0Y/RgtGMINC60LDQuiDQtdCz0L4g0LHQu9C40LbQsNC50YjQuNC1INGA0L7QtNGB0YLQstC10L3Q
vdC40LrQuCDQuCDRgtGA0LXQsdC+0LLQsNGC0Ywg0YHRgNC10LTRgdGC0LLQsC4g0L7RgdGC0LDQ
stC40LIg0LTQtdC90YzQs9C4DQrQvdCw0YHQu9C10LTRgdGC0LLQviDRgdC10LzQuCDQvNC40LvQ
u9C40L7QvdC+0LIg0L/Rj9GC0LjRgdC+0YIg0YLRi9GB0Y/RhyDQtNC+0LvQu9Cw0YDQvtCyINCh
0KjQkA0K0JTQvtC70LvQsNGA0YsgKDcsNTAwLDAwMCwwMCDQtNC+0LvQu9Cw0YDQvtCyINCh0KjQ
kCkuINCc0L7QuSDQv9C+0LrQvtC50L3Ri9C5INC60LvQuNC10L3RgiDQuCDQt9Cw0LrQsNC00YvR
h9C90YvQuQ0K0LTRgNGD0LMg0LLRi9GA0L7RgdC70Lgg0LINCiLQlNC+0Lwg0LHQtdC30LTQtdGC
0L3Ri9GFINC00LXRgtC10LkiLiDQoyDQvdC10LPQviDQvdC1INCx0YvQu9C+INC90Lgg0YHQtdC8
0YzQuCwg0L3QuCDQsdC10L3QtdGE0LjRhtC40LDRgNCwLCDQvdC4INGB0LvQtdC00YPRjtGJ0LXQ
s9C+DQrQoNC+0LTRgdGC0LLQtdC90L3Ri9C1INCyINC90LDRgdC70LXQtNGB0YLQstC+INGB0YDQ
tdC00YHRgtCy0LAsINC+0YHRgtCw0LLQu9C10L3QvdGL0LUg0LIg0LHQsNC90LrQtS4NCtCS0Ysg
0LTQvtC70LbQvdGLINGB0LLRj9C30LDRgtGM0YHRjyDRgdC+INC80L3QvtC5INGH0LXRgNC10Lcg
0LzQvtC5INGH0LDRgdGC0L3Ri9C5INCw0LTRgNC10YEg0Y3Qu9C10LrRgtGA0L7QvdC90L7QuSDQ
v9C+0YfRgtGLOg0Kcm9iZXJ0YW5kZXJzb25oYXBweTFAZ21haWwuY29tDQrQoSDRg9Cy0LDQttC1
0L3QuNC10LwsDQrQkdCw0YAuINCg0L7QsdC10YDRgiDQkNC90LTQtdGA0YHQvtC9DQo=
