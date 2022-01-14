Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540FD48E974
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jan 2022 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbiANLvA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Jan 2022 06:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbiANLu7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Jan 2022 06:50:59 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA0C06161C
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 03:50:59 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so21711740pjf.3
        for <linux-nfs@vger.kernel.org>; Fri, 14 Jan 2022 03:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=h0ot/9Bfj6gbigRp33fTwcN2wrGdo9obxY37DOqaflo=;
        b=UqaivxmB0ISUX7Oxm9jowEz7vblhwOxA6yBvmSDo63xyf/A9m05dwaef2H4hQG//ih
         52izJHQLYd+2oefALvskRy5Vl77l3MUx05aT6BRXnQJQsQkXUPWKzi/qYh/aSrlFZl9T
         dBucxfQUaHE07JxQV+b+BWJkqt+5MNGZO7RZhoer/IrbC+vEclQlM72ZqdipGTpjLRuA
         Mi7ix5BUEN5M3tl7597uZvhJYMalDWN+mHr9EOLo6r+DRRCO99haSvC6JCTDSnQk8HTV
         m26VAn2IRX15EzbSClg9rKz0UclD+6UcaaIVBRRF3gfoGAU/P/0EbF+lH3pyAIRiJWNi
         n5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=h0ot/9Bfj6gbigRp33fTwcN2wrGdo9obxY37DOqaflo=;
        b=c+m3tIG/dHkzfRDxf3ijNuFQCVf5naCnkTO9NwEwcuPOo9VdvI3nfJvKC6tweSobL1
         RmCR/bGgs4e46NEvvxaI5dz8kjbsCH8QzcMUoP40ZPMLHpIOCKOx804292gSkxXKiBVn
         xx+5OqoSQPJ9NtBqafD/OsvD1Whcbduuc+3g9FRM+D0IzoWa8v0DNMbLRoCYLPKaHw1c
         lYnYJnqUfLwSPv7M/6/7v5OPKHIo0yL6F936151XbvP+fkm5O1CMxBM5sCWjs1JQe2im
         fweMnFdTOLyUg3vIcKe4vl8DhS38NxJlZ8NeAo9v7PpsbRPouRV3ttODkJ38m8fvwFXs
         G95Q==
X-Gm-Message-State: AOAM532clOJhfJPEdXCz6DuHghmS3zIPZ6QQQWM25LT9GPQseIo6grs9
        QNs0nYLzLnwmY+gt9Koq3Mot82PvjwIYlmH00WI=
X-Google-Smtp-Source: ABdhPJxvzUq2BojFr3GJ3LgW3yay0UwwoxyQkCZqJ6B8tvdUcX7m3Ub9ENjMg5OHsf+d2rMGMMbwcs69dKf48Q1Ap9U=
X-Received: by 2002:a17:902:bd94:b0:149:c926:7c26 with SMTP id
 q20-20020a170902bd9400b00149c9267c26mr9198996pls.64.1642161058998; Fri, 14
 Jan 2022 03:50:58 -0800 (PST)
MIME-Version: 1.0
Reply-To: ymrzerbo@gmail.com
Sender: dr.siaokabore@gmail.com
Received: by 2002:a05:6a20:2318:b0:6b:2327:c203 with HTTP; Fri, 14 Jan 2022
 03:50:58 -0800 (PST)
From:   "Mr.Zerbo Yameogo" <ymrzerbo@gmail.com>
Date:   Fri, 14 Jan 2022 03:50:58 -0800
X-Google-Sender-Auth: 4JEhKKPWrxVMzx4GWmhnHzqfkaI
Message-ID: <CA+rg4NvygDH0MsaEZ4VPLEaXMsuK0GX+qEtefiM-HFqpwSpg4w@mail.gmail.com>
Subject: VERY VERY URGENT.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hello,

My Name is Mr.Zerbo Yameogo the Chief Operating Officer of  Bank of
Africa and I am in need of a reliable foreigner to carry out this
important deal.

An account was opened in my bank by one of my customers in the name of
MR. THOMAS BAHIA a Dutch National from Germany who made a fixed
deposit of $18,500,000.00 (Eighteen Million, Five Hundred Thousand
United States Dollars) and never show up again and I later discovered
that he died with his entire family members on a plane crash that
occurred in Libya on the 12th of May 2010 and below is a link for your
view.

http://www.nytimes.com/2010/05/13/world/middleeast/13libya.html

Now I want to present a foreigner as next of kin to late Thomas so we
can make the claim and you can contact me if you are interested so I
can give you more detailed information about this transaction. For the
sharing of the money will be shared in the ratio of 50% for me, 40%
for you and 10% to cover our expenses after the deal.

Please for further information and inquires feel free to contact me back
immediately for more explanation and better understanding I want you to
assure me your capability of handling this project with trust by providing
me your following information details such as:

(1)NAME..............
(2)AGE:................
(3)SEX:.....................
(4)PHONE NUMBER:.................
(5)OCCUPATION:................ .....
(6)YOUR COUNTRY:.....................

Please keep this absolutely confidential weather interested or not.

Thanks.

Mr.Zerbo Yameogo.
