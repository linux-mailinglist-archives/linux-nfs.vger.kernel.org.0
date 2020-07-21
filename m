Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65918227B5A
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Jul 2020 11:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgGUJGP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Jul 2020 05:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGUJGP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Jul 2020 05:06:15 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34091C061794
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jul 2020 02:06:15 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id c14so9718331ybj.0
        for <linux-nfs@vger.kernel.org>; Tue, 21 Jul 2020 02:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=nHNUw5fKJrBs4Yw/4gDozM7ufiIL1f9OJbiyNszRX0w=;
        b=VlH8BIVe7UjCus7mk/HVIcj9CjuN9/WCh6jAcB5loX9VZJXc+qYarR5v4abPvO+eju
         wDjZ1drLhJ6BKfEvEPSr0BalM6pE9fdiy1oK6oQquzga7YUSh9XUA5g6uV5TnotpAMAk
         DniPqTzZYd4oqQtD5pCZS6vJdV0lYCOsc4soVJ6vB+WB3jiiUErUxt3jEQgFj7VZDi9N
         1bdHk4pjtwcIX6cMcMHQev8dw+BBsz8y/P9HTYLWlAMxgUnx+CRIHil3EfRVjg9jZ8zk
         3DdVg3neq1nUvnhT+G+raHsgxK6Lt7pKMxR9AcdOWY6yIjDVkPZt0NzWDfeF4hj84jze
         xaQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=nHNUw5fKJrBs4Yw/4gDozM7ufiIL1f9OJbiyNszRX0w=;
        b=QBBX1Cj24AXFRmSiXn5gDc7sqOQCB7Ojr8i/GOp4kuDstXS/onY1VqByoDM+hbh62K
         O6pdIxDtdGK0NvRKbp4F1AP151+YEhuYCNvvp3bxHpqCNCoEn9W8RWkDYQUi8VZUKXNM
         orMIUZxhOyZNMKpQ21lbGn+tkKfLBH17R6DB0nHbqapI50iuFOlGAM3+pIIwPzUBYO2S
         FpXyGx8AehUsr3onTplpXGxx6dTHXIqPHfSVKxRiCTQRuxf9zH272XGF1pnVeINKvmOq
         cYPp6Mft9EGXzDY6C4ATjxErcmoAUcJrxwmYVSuyTP1BYqHly9iIly/jK0661PhhQEf5
         H++g==
X-Gm-Message-State: AOAM533B/rT/v4VstR3Whxe3T7w8+VIZX9l+djItQlXaA8UkiJ6c6XKu
        n10gLNS7FYEi2AH5NHMXtCxb3y+uBQjptStgutc=
X-Google-Smtp-Source: ABdhPJzTL5QpfD2u/TzqnaH1hFaMSn0hPxPonY2PWViSmKY5HQomScFUmyvLAAmbV6Vv/jHG+SFeZg+SyUAmZE1zhuY=
X-Received: by 2002:a25:c345:: with SMTP id t66mr40558442ybf.218.1595322374461;
 Tue, 21 Jul 2020 02:06:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:698b:0:0:0:0:0 with HTTP; Tue, 21 Jul 2020 02:06:13
 -0700 (PDT)
Reply-To: jinghualiuyang@gmail.com
From:   Frau JINGHUA Liu Yang <alvinteddy830@gmail.com>
Date:   Tue, 21 Jul 2020 11:06:13 +0200
Message-ID: <CAM5-t4+LvjVWNxZ6qEiGKcPQVByx7GC25fkQm3e3A5OR+=W4oA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=20
Guten Morgen,

     Ich bin Frau JINGHUA Liu Yang f=C3=BCr die Mitarbeiter der CITIBANK
KOREA hier in der Republik Korea. Kann ich $9.356.669 USD =C3=BCberweisen?
Vertrauen?

Mit freundlichen Gr=C3=BC=C3=9Fen
