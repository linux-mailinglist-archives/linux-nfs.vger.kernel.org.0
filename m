Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F9C7DDE1E
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Nov 2023 10:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjKAJGq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Nov 2023 05:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjKAJGp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Nov 2023 05:06:45 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DB6128
        for <linux-nfs@vger.kernel.org>; Wed,  1 Nov 2023 02:06:32 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1ea48ef2cbfso4362321fac.2
        for <linux-nfs@vger.kernel.org>; Wed, 01 Nov 2023 02:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698829589; x=1699434389; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sa9DtWbLtNuJ7Y5/oMxCQPD6X9Wi9WmXaj8ltCuZCr0=;
        b=jakJQQLzz6QPoyPszFAohSfBxhzdgs2ocY2D8VSZg14FGC97zRkaX/6uh5/cPkXYGE
         9SoXGxSIwwOnofJsVEq7QA1EcIZp3YEGO/Lfqt0omLxUUfwgbcbAUMwnFaJJ/gShJa0I
         FyGteNONldHaYexxZG6AcGp4VIij0Bjp8F1Tq5mgB17S7l38pHOOY8ZwfzjAGxuiCdfM
         addHNQKIm5wfoxb+z7O/nzVEEFbuxyCN8FpGr/hI/KyvpuhDur4TfJE+WE7UuntiWs8w
         RFVce2f3wDOM/z09rqxmv7xJZW7kSVh1Rbf9OeWjiWqsFrq4zfN19SNS0Ob3V4ywC2Q3
         Ck6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698829589; x=1699434389;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sa9DtWbLtNuJ7Y5/oMxCQPD6X9Wi9WmXaj8ltCuZCr0=;
        b=QVpux7sHek/NwjY7lDiH3maKJ/Ms99x4GmUcaJkTQte6tP8RSynuLmSildukVC2MXO
         8t7YuLIJABOt3pDP9aOjb2lgYeITexxXWXMaJIxYl5lQxfIT6gGluSo21xMY1G4Cj1CI
         G4OeQME/KArK9r8c+/Bh87u8uq4iytmUwe5QA61SbH7ORSiymSDj3J0UlvD9hjE/4mZK
         obOvHF6BZU0KIV3qQlmDbAvYufRdRhGPkuWxIyCo+gH1PZ+pm8Eo3B4TZMn/Niu02lol
         UxWbduorU/bnLjAp/AIdea9WXTm3BSNhbqcggcgC9IAcQH3K4McBvXNF4gMmSiVYg2up
         KX5Q==
X-Gm-Message-State: AOJu0YyQDjP2bghXOLrqefLPIL2TfpzSiZzpgroZzmpxDD5PCF+l4lZz
        O5zWZBfGnUV9YRG9QFAHgM7PvZau6GC3+Hv56O3U+aasi4w=
X-Google-Smtp-Source: AGHT+IHdYshxb9KuTRxjfiLP4BZ25sKw5pgRFzOoV6ZSvHlqjx8XNFpv0gUFAqf+iXwGaLN4v7r0Agc5G+AyqmDNBXg=
X-Received: by 2002:a05:6870:bf17:b0:1e9:e8a0:12dc with SMTP id
 qh23-20020a056870bf1700b001e9e8a012dcmr18788685oab.24.1698829588979; Wed, 01
 Nov 2023 02:06:28 -0700 (PDT)
MIME-Version: 1.0
From:   Martin Wege <martin.l.wege@gmail.com>
Date:   Wed, 1 Nov 2023 10:06:18 +0100
Message-ID: <CANH4o6Md0+56y0ZYtNj1ViF2WGYqusCmjOB6mLeu+nOtC5DPTw@mail.gmail.com>
Subject: NFSv4 referrals - custom (non-2049) port numbers in fs_locations?
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Good morning!

We have questions about NFSv4 referrals:
1. Is there a way to test them in Debian Linux?

2. How does a fs_locations attribute look like when a nonstandard port
like 6666 is used?
RFC5661 says this:

* http://tools.ietf.org/html/rfc5661#section-11.9
* 11.9. The Attribute fs_locations
* An entry in the server array is a UTF-8 string and represents one of a
* traditional DNS host name, IPv4 address, IPv6 address, or a zero-length
* string.  An IPv4 or IPv6 address is represented as a universal address
* (see Section 3.3.9 and [15]), minus the netid, and either with or without
* the trailing ".p1.p2" suffix that represents the port number.  If the
* suffix is omitted, then the default port, 2049, SHOULD be assumed.  A
* zero-length string SHOULD be used to indicate the current address being
* used for the RPC call.

Does anyone have an example of how the content of fs_locations should
look like with a custom port number?

Thanks,
Martin
