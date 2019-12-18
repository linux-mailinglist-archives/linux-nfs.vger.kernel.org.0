Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBF6B124FA2
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Dec 2019 18:47:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfLRRrZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Dec 2019 12:47:25 -0500
Received: from mail-vs1-f49.google.com ([209.85.217.49]:42454 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726960AbfLRRrZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Dec 2019 12:47:25 -0500
Received: by mail-vs1-f49.google.com with SMTP id b79so1938928vsd.9
        for <linux-nfs@vger.kernel.org>; Wed, 18 Dec 2019 09:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=pownnmviEPeh8bQHRTFen545GzZtQ1auRRTUoKK+Jd0=;
        b=ZRUCH5+kncFN1nfVl3Vpuf7Cb64eKiyPpt8WC31viAfNB02AK4+PEu2RQjdHWs/CMt
         ccTb+zpGfO74fufz2d/ELfRmG3bzt8KZh06UyVxb1oJyjgdwwv5np57VEbggxjc+nQIH
         NlLB8UFM/MpwDJS0MSCql1vQkQdNgkVhUZil95VwTDkQfk9X7N+tNPVT4gAqj/abTqZW
         yZxgbP7WZLtxjzTE/LJDIiiEUNpDnJxFPPrMMbS17Xrd+ek9lhEdQx6cVebH9tpLiwO5
         TPmdoPVrABeYxFlelNxJY5kPyYhxP5O6hde8Kdy/b1fu22ka3J6ZlMKJXu6zWh72MWJz
         kY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=pownnmviEPeh8bQHRTFen545GzZtQ1auRRTUoKK+Jd0=;
        b=EMbLE72mlIgvP0tWBW0ra2oiUZECALTQEUVPj2v1iIQLa1NGJbI8/wmnwbVx6hKywV
         H2OZGq/g8gPURozkyY6WM49t1q6ma0mB8n5cjhwLZdGaj7ZTC558r7aeLeXXce+276ci
         KNw71Ueo+cbT1MUTTrFBdyETq/2lCOkuuco081aBdiZzpKNrace1exOgroXrNK449hiw
         S2WpDNH5PqBopZ0WF6ZnYoWMzzG3HzM0QtczgHuhXrfpk9ib9T0UBOb8IUMwsJ0T4nZr
         frQZCfD1DwLAQEl1FYe4WJFICwovFt0KszW+2900W3JI+5QQnmxvDL7E7OnZ4EMXD4px
         U6Ng==
X-Gm-Message-State: APjAAAUvL2Qpyd1J9diVGbN7TkJf9W2CscldOLEZI2aOk7ow3xIGW1q6
        u/59CRlgCrLjXRJK0A3yt71C8FF9O3+qKwOSTVaWTw==
X-Google-Smtp-Source: APXvYqzFmWUM1bmSetK4mUAI9k99Vd9HsxhOjhcxw5pcnmrehjTcfAGH7rN8v8/hNz5kz/vYtNzj0BpFn6ucZNm0tnI=
X-Received: by 2002:a67:c90d:: with SMTP id w13mr2300249vsk.164.1576691244429;
 Wed, 18 Dec 2019 09:47:24 -0800 (PST)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 18 Dec 2019 12:47:13 -0500
Message-ID: <CAN-5tyHJLh8+htpb47Uz+ojo5EfrpP=zyE-Vfk=HjvBgK591=g@mail.gmail.com>
Subject: acls+kerberos (limitation)
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi folks,

Is this a well know but undocumented fact that you can't set large
amount of acls (over 4096bytes, ~90acls) while mounted using
krb5i/krb5p? That if you want to get/set large acls, it must be done
over auth_sys/krb5?

Thank you.
