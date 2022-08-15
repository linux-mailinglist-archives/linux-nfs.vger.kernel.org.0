Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5339592FAD
	for <lists+linux-nfs@lfdr.de>; Mon, 15 Aug 2022 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242720AbiHONUN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Aug 2022 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242719AbiHONUM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Aug 2022 09:20:12 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88131BE8F
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 06:20:10 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id n4so9027917wrp.10
        for <linux-nfs@vger.kernel.org>; Mon, 15 Aug 2022 06:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc;
        bh=VReCwsN/r8zd7YEhiE290SZ/2en0pyTA7PFDH5oC1p8=;
        b=J7YRO2HdKgUYPF/IsxOr/KcBJRqelpVCjYumwU7rBoe9OsV7Vvu2tg/7kLqzdbBlla
         dU/xyiSAuYqT02BDGW7IFkHfKTTONfwdRTDT94ZHsTHWO3uQBJ9QcnamxgWzHDg5inva
         KdUEv6HraZEkT1LcYqQPnCyxUxLvvhzo4/M5TH4p57/J+TrL5lqcqYHkA0uKp3hqZ/co
         Ql3Z5RkAxve35zF8zq8SDNLbJ2vfOMQ5Tn4LGhT8gl7vw5WHI8UMHZA64/NYtGy7Ovw/
         xZmBeOvZhoTogJUMOrnh8MW+x0J9xYU4IRi+BAyg5GZRugdCYOcJbx4iGxdLjnNoNvfi
         bE1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc;
        bh=VReCwsN/r8zd7YEhiE290SZ/2en0pyTA7PFDH5oC1p8=;
        b=BOXxFzXeLnOPT9DoYc/CzR8E4lA6SafmXOPexCklQSUYHRzGHXBk6uXryRg6FzAuAB
         gq8fcyWf5Lc0HlwR3WVMijSUkGlNYwvRMzgeNgzfRyydMccMRHYRQCErNSe/4T/Cy8Y3
         h8hZxFIxqLb3v/CFe1j56PqBBkMu3WotPcgacZw8bNlzE83df5KMMQy7SgG6pNT0XjgE
         0i5qxCmxQbC6oe7I9t+5tVzegd6BjRzJ006ZvRImtHVy0A3ym+ToMxE+nob453AfdtiZ
         wWfwkRjS/5PYYQu5/yVr7zmK6swV5LZrGvFjkC7WV8TfbM3spd1HHxH5MQrNjxzai8Lg
         hXbA==
X-Gm-Message-State: ACgBeo1cix5q1EQLtU1xZo1NncdlDf41Si0hI5O+qlUDYmdxthPdazhd
        dEsoEgLtR+FWW7Jm+OcXLQpmblXCMkhmwccTbOQ=
X-Google-Smtp-Source: AA6agR536BzJBr4ZLBYQxzQcfzNNgu0zbuf1XL+TrQSsjDxW6cMFiiu1SXfJKKA+hFAO5JNjo9YZJ1uOwRzAMCRrN3o=
X-Received: by 2002:a5d:6811:0:b0:223:8131:e580 with SMTP id
 w17-20020a5d6811000000b002238131e580mr9121342wru.77.1660569609118; Mon, 15
 Aug 2022 06:20:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e410:0:0:0:0:0 with HTTP; Mon, 15 Aug 2022 06:20:08
 -0700 (PDT)
Reply-To: tescobank.uk1997@gmail.com
From:   Tesco Bank <olufemielizabeth12@gmail.com>
Date:   Mon, 15 Aug 2022 06:20:08 -0700
Message-ID: <CAME+Liga-m8x9Wh259m3kcdMOAKQFvWSbGzJUmAaZHhSTq81HQ@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:443 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [tescobank.uk1997[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [olufemielizabeth12[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [olufemielizabeth12[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

--=20
Hallo, ben=C3=B6tigen Sie heute dringend einen Kredit, um eine Investition
zu t=C3=A4tigen? Ein neues Gesch=C3=A4ft gr=C3=BCnden oder Rechnungen bezah=
len? Und
zahlen Sie uns in Raten zur=C3=BCck, wenn Sie m=C3=B6chten? Kontaktieren Si=
e
jetzt den Kreditagenten der Tesco Bank zusammen mit diesen Details
unten, um weitere Informationen zu erhalten tescobank.uk1997@gmail.com

VOLLST=C3=84NDIGER NAME

ALTER

LAND

TELEFONNUMMER

DARLEHENSBETRAG

Danke
