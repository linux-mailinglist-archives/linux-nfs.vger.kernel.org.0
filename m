Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2BF5158B6
	for <lists+linux-nfs@lfdr.de>; Sat, 30 Apr 2022 00:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381634AbiD2W6R (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Apr 2022 18:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239840AbiD2W6Q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Apr 2022 18:58:16 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE542D4C64
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 15:54:57 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id d6so10604932ede.8
        for <linux-nfs@vger.kernel.org>; Fri, 29 Apr 2022 15:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=eOE3sN8s+vRwdFkxN0iX4yonGV/3x98wUVoysuuPgnFvh7chzOa9fju2SB2F35QgGt
         ijKRvhsGcPL6mDgi8ndPsjMyLnauI5RtlRAsRq/D/orWjjdIEFTKjBwumiRnFWP6Aj6q
         LSZv4tn0x3M/isVWGBsMRoFz0tZ7VeGgPDiVrX+kW13L//w6kciTY819ulemrBLH9Afb
         fvMjdIR+r1ESgzTZEVVO/PedMR10I/qu7nMWN1cr/5/Fkm57AksPWCyRZG8s43aunccX
         bA0ZT7WYmKAO+OEIC+m3SCOA/cFs9rsaeetMBbUXZMX35aXiKvDFsxE6IdGjs9TVpWht
         HJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=MUPE+WCKiaoxRAdnteR3TsIHrvUD8FAr/F1eBQt4pX0=;
        b=h/zcBIztz7q7EIh4CpDXgCYC306f4X2h/Rm7HWseGzohLPJ7kMoMUm8epuAvr6QtBe
         1CQNYE1FP6CiVBJ1J0UiQcmnQvwjABVBNgJnfombrsYcYpRUgkpjNlGhAFzPAweaTgzi
         VFM99M4DnDO/ywXCV/bo8YRdMnb37nmEJEk8S0uQzZwoJJtXuLNHNjCzg5uYxbZGbaCX
         9a0+yDaHIM1jwreIIPDRTtIcD9AVCvSs3OddbJQ+Xnr4CaRNk+Dv+xA6O8IEV2QyPXSC
         dH3+wh0cygtD8lv11bBrqTZ0SrvnoPt8pqoxWfQRqYrCfK3tGJD9MBpQp8KU+jLTOWAB
         Wo/w==
X-Gm-Message-State: AOAM531DL4rKIm4CMVsUXZr7QVWWOvP+zjuIo/wo31rH2+MTV8jwZVy5
        PkE7aQ1kg0yuz0IoyZPkz9Kq1xdBhYDW+lEQZmE=
X-Google-Smtp-Source: ABdhPJzDT0e1Vr0coggEherD5r93aaW+0mvSf1obNIyKdiD/PzCIOkQ3Lr1ZefcstYEaVCQzyOZ6h4NOWoASjGWJ9CY=
X-Received: by 2002:a05:6402:3456:b0:425:ab60:1b00 with SMTP id
 l22-20020a056402345600b00425ab601b00mr1588014edc.71.1651272896428; Fri, 29
 Apr 2022 15:54:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a689:0:0:0:0:0 with HTTP; Fri, 29 Apr 2022 15:54:56
 -0700 (PDT)
Reply-To: jerrydosso@hotmail.com
From:   Jerry Dosso <jerrydosso20@gmail.com>
Date:   Sat, 30 Apr 2022 07:54:56 +0900
Message-ID: <CAK7AM3p456RQDjBP+i-7mSnB9D1fFv61bRwg1rasPVuZRDgwhg@mail.gmail.com>
Subject: Jerry Dosso
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:534 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4880]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jerrydosso20[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jerrydosso20[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

-- 
My Dear Friend,

Did you receive the message i sent to you?

Regards,

Mr Jerry Dosso
