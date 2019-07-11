Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337F765FDC
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2019 21:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbfGKTGv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Jul 2019 15:06:51 -0400
Received: from mail-ua1-f53.google.com ([209.85.222.53]:42254 "EHLO
        mail-ua1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728747AbfGKTGv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Jul 2019 15:06:51 -0400
Received: by mail-ua1-f53.google.com with SMTP id a97so2979736uaa.9
        for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2019 12:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pV5gb7I3WIrX4qBGHfvYRSIAtPqV6eR7Y3fpt7W1/b0=;
        b=Mf5f0H8MxDcFHFMK62RFeyPJ+SyUwShw0bBYafX+TQ3xi5JgYlvR5NEH1TB4Zjx4vN
         UWvErs7BVKz9rEwTUgTshr1rYTAXE6BwrdK6HDdK1oFkunkPDwErYFQhnzCARY5Lk7mz
         RO7GFNusfT5yuP9CVxEjBABo/CK+WeHU0JBsbo5WhOYSo0urZVOUkALaHvYjepasEBa4
         WeC1EfgbSXmpW7Y+ANYiRZ+KFYjm/7deCC/id3hCuxLVC/tVucbExwmqB7UYmHnbusVy
         Bc5F5vt90uSGHG2tbFhU3IwBmlUIozhTjvS8pAV2ybOksG2x+3oNGTnxo7za4X3G7SbK
         ehMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pV5gb7I3WIrX4qBGHfvYRSIAtPqV6eR7Y3fpt7W1/b0=;
        b=C+XjOFoNC0AQlafJaardLJxFnss/UHcn1ROIFHu2DjWvKIwckNOq83ZK+ODJ5luwUq
         JutnHr7Mxzf4GdcQvBYRCR9u2zJBDMWTRIqLdchSenVvVgtRflrkEUhq7kmr9RTkAYzy
         bsGpEYnBMSuT/rlpRDI+s1txk5gUAo8kn7nATlTiALkm08yQamQkoe2t9Z+75/N8i+OA
         tFMGe+0F926eWsTgGCRBg5BRdJ0d57KDBusdsH5Px2mnsNnZRS0g7gfMDGAedW2b1VGa
         Y/VI9t176HbklbzLz6RKGp3DBYRbbzU+ju3mrt+gx8Lb0MPIGslPfYP5rN/lIxhMPLwu
         yTVA==
X-Gm-Message-State: APjAAAWeuRxmX0SEXSvCByn+IVYZ5rOebiOI48Y67jm907YY1pG8JUbj
        /6uCwoO6aU4U9V1GCNQtzjZl2TyG647oJ8536PlzYxQY
X-Google-Smtp-Source: APXvYqyQAaxI48uubKwMdWoBW1shYKhBWHhnFe+RudxQ4OpG9dAISRPpze97d5KxkeMerQN4Fho2mDa5pfLmqux2G+8=
X-Received: by 2002:ab0:5ea6:: with SMTP id y38mr6309298uag.40.1562872010304;
 Thu, 11 Jul 2019 12:06:50 -0700 (PDT)
MIME-Version: 1.0
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 11 Jul 2019 15:06:39 -0400
Message-ID: <CAN-5tyF2AL8Bx5QS3HGYzzvjw5vnkfmFxWEmqe_BWfvWCVtDFg@mail.gmail.com>
Subject: multipath patches
To:     trond.myklebust@hammerspace.com, NeilBrown <neilb@suse.com>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond,

I see that you have nconnect patches in your testing branch (as well
as your linux-next and I assume they are the same).  There is
something wrong with that version. A mount hangs the machine.

[  132.143379] watchdog: BUG: soft lockup - CPU#0 stuck for 23s!
[mount.nfs:2624]

I don't have such problems with the patch series that Neil has posted.

Thank you.
