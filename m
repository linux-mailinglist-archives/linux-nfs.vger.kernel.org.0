Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7EF367425
	for <lists+linux-nfs@lfdr.de>; Wed, 21 Apr 2021 22:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244805AbhDUU2y (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Apr 2021 16:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235996AbhDUU2x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Apr 2021 16:28:53 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3620C06138A
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 13:28:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id h8so10690546edb.2
        for <linux-nfs@vger.kernel.org>; Wed, 21 Apr 2021 13:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=BTxeOvItUf/hQPVBleOY5zaWBy/5NEeiG69sqLNw6SY=;
        b=QUhudc+dY9APEI3AjukEm29Vkwfr1+uMFpQkygQuzbzuEExw3Mzqx3Tl2om/LIMLai
         e/HS28L4pkXhkSqAEiiOTRxppDsXU8BnothjmlPFUs87t3Ky6o3b8ihwLa69YN+CKLH1
         llQTXExEG+4PXMyea3MC68ZmGDygYPpueTZDgDMDnvN1ABrcWZsUhW73Rb4MEaJhVF9U
         vO3U6ZSyl7Bngc/vQmc8TFpa7gpM3SR/UFfnJNaOpqTbDDFCS1hqgXnTIa6nxAr1KM8E
         8BTJOhpyR3b7ASdcRWL71ERupi93wSpq/zuQUi91kRuiTWH7AYgAo1LGeeETuIqlPDX4
         IQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=BTxeOvItUf/hQPVBleOY5zaWBy/5NEeiG69sqLNw6SY=;
        b=DVoD8Ds79mHlL9NJM3ArZhUoLNC4WKG6KHGePoJJTsMnXuysUgVIK3C2gZwI8abLLe
         azAO5wizBqeJRd+wJFVgvCeBhGgboEsGkXeW9XJP7Gi1PpcNvaV+2kGKUR2aFe2obfj+
         +54e3hRFfecAgeUodw5kIiD4TZIFIBdJoaeyWV6tJXZGPhny6RTosYcXAu0r4VIdmA1t
         oFZo6dEnkp+UqItoCie7xA2e2kQ24cWStwRYBQAlM+JwyZnoMTkSwf89V5lgyfCMzZKN
         FRD8pCq85zBfP0UI9wCLIYiFpNDCc3xmoFOaBFqFN+f4+4q4s4LxTlEVL6uCExMIAIal
         9/Dw==
X-Gm-Message-State: AOAM5311DKYRIlS5K2+YpgqyC7Lhr9MqvUoa4WUIxWU53+mGMcotTrqc
        LoI58X3aQpcmNlf0dA/R2TdBC+f1qmTlAk7Ov2iF0Q==
X-Google-Smtp-Source: ABdhPJzsQJ7ViNL2kufuHFGKH/tMM4GjkaL36Yv5Pr1Wfer7c9HJJdpBWIPu4Z65zWBVeRiPSBN56etGEDkVg7HhE24=
X-Received: by 2002:aa7:cb90:: with SMTP id r16mr41647616edt.139.1619036896139;
 Wed, 21 Apr 2021 13:28:16 -0700 (PDT)
MIME-Version: 1.0
From:   Weikeng Chen <w.k@berkeley.edu>
Date:   Wed, 21 Apr 2021 13:27:40 -0700
Message-ID: <CAHr+ZK8xp5QU8wQHzuNkJdsP20fC=nW4B33gwMUwHY82f_u5WA@mail.gmail.com>
Subject: Re: [PATCH] SUNRPC: Add a check for gss_release_msg
To:     tytso@mit.edu
Cc:     anna.schumaker@netapp.com, bfields@fieldses.org,
        chuck.lever@oracle.com, davem@davemloft.net, dwysocha@redhat.com,
        gregkh@linuxfoundation.org, kuba@kernel.org, leon@kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, pakki001@umn.edu,
        trond.myklebust@hammerspace.com, w.k@berkeley.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

[This is the email that Theodore Ts'o replied to, but it fails to
reach the email server due to not using plain mode. Here I resent.]

(Note: this thread has become a hot Internet discussion on China's Twitter.)

I am a graduate student working in applied crypto, and CoI: I know one
of the authors of the S&P paper.
Some thoughts.

[1] I think the UMN IRB makes an incorrect assertion that the research
is not human research,
and that starts the entire problem and probably continues to be.

It clearly affects humans. I think UMN IRB lacks experience regarding
human experiments in CS research,
and should be informed that their decisions that this is not human
research are fundamentally wrong---
it misled the reviewers as well as misled the researchers.

---

[2] Banning UMN seems to be a temporary solution. I don't disagree.
But it still might not prevent such proof-of-concept efforts: one
could use a non-campus address.

It might be helpful to inform the PC chairs of major security
conferences, S&P, USENIX Security, CCS, and NDSS,
regarding the need to discourage software security papers from making
proofs-of-concept in the real world in wild
that may be hurtful, as well as concerns on the sufficiency of IRB
review---some IRB may lack experience for CS research.

Some conferences have been being more careful about this recently. For
example, NDSS accepts a paper on
a browser bug but attaches a statement saying that the PC has ethical concerns.
See: "Tales of Favicons and Caches: Persistent Tracking in Modern
Browsers", NDSS '21

---

[3] Let us not forget that the author is using their real campus
address and is open to such pressure.
Thus, I think the authors, as students and researchers, have no bad faith;
but they are misled that this experimental procedure is acceptable,
which is not.

Sorry for jumping in...

Weikeng
