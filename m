Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3DD700A52
	for <lists+linux-nfs@lfdr.de>; Fri, 12 May 2023 16:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241577AbjELObS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 May 2023 10:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241481AbjELObK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 May 2023 10:31:10 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9D81492C;
        Fri, 12 May 2023 07:30:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-307c040797bso2125980f8f.3;
        Fri, 12 May 2023 07:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683901846; x=1686493846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjyeGw2WZYmUelORXDy/YgHPMeeEb+Ki3snagjKtzwk=;
        b=SZ/p3LMZeCOzwb0h7K/rj1SbxcKSmaes73fo3RvmcgNWV6nFUflsKAy4D95c2zCUmr
         Mjl1dUG10Uoy81idKGmnX4tbqiuG3DcZEfsdzccLP2PDKG6siDh0h4wBT36eUUqbuOxJ
         6Yne0w1txmBMWtCVqzZAqc2h/G+ftUtP2Tpr7CYQCZOA1vFUAkLjPd3r4/LbKWULi0Xl
         ypiY1KmgDYqZjqWHhB6X5BhQX/wMaauCiyeKrsl48lLrloXTwa/DHBBnQgHQXzPAzQ+9
         b6pk5cffcrHBwV2WZi934BGyPuCz9TwNgcvWukTuICfcS2mEKem3cs6HvzdXw6ZOYOGU
         HwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683901846; x=1686493846;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjyeGw2WZYmUelORXDy/YgHPMeeEb+Ki3snagjKtzwk=;
        b=LiIQU2N3OCek1xdFhUCT+s3T7GzlonosHRqBsrSIh/nMDjKKd0PkWqccknHtMXfQwy
         j7sSGVOLUfxEgGOBF6GSzhy6f08nHJstKTCrl9C+m2Q95d5xzHZqTYZF14dw3P3U5OWR
         5tLDOSF62v5VaA0dyPn+DwKm7wEaCFfvYRvU2bLRH37ks+w59adDS40WzP9ESrM847FT
         FaAl1Z5kKQPo2DW1QcsgtGhcjJKLiTNl+P4XRpZevBSMhkPNZU1KBFOoqUHVzaXv+V2l
         YFXvFL5MRdetB3VHrcKpf48qF9ds/MnnMKqy0iPuJdij7WnKRj7cnlkuMvSJHdLDUu/J
         Nihg==
X-Gm-Message-State: AC+VfDziZ7lw1N4bFE5rFjFOgIch/1kLIRzQ+4JWIhKAxRT33o+y6Q/9
        BozY/9bJfZXMEClnQiNSZHp8kSZDBXukgT+m0GY=
X-Google-Smtp-Source: ACHHUZ5BxevE+YysvQ4ix6pOjzCc7Qs6fIlpr3Y0zSfuNDJC2QcmYauzrH7Xw6bHEAg/cLA8oqWrGoFvu3pF1AcDC40=
X-Received: by 2002:a05:6000:100a:b0:304:77a0:4ccb with SMTP id
 a10-20020a056000100a00b0030477a04ccbmr16985112wrx.2.1683901845416; Fri, 12
 May 2023 07:30:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
 <72239648-C807-4CDD-8DA7-18440C83384E@oracle.com> <202305110927.12508719D2@keescook>
In-Reply-To: <202305110927.12508719D2@keescook>
From:   Azeem Shaikh <azeemshaikh38@gmail.com>
Date:   Fri, 12 May 2023 10:30:34 -0400
Message-ID: <CADmuW3UbHBWN0JzXMYX667hkXyWJY8_88K1sJfRnKNg7_u38=A@mail.gmail.com>
Subject: Re: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
To:     Kees Cook <keescook@chromium.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Chuck and Kees for the review.

> > Actually netid should use the __string() and __assign_str()
> > macros rather than open-coding a string copy, I think.

Do you mean something like this?

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 4183819ea082..72a906a053dc 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1365,19 +1365,19 @@ TRACE_EVENT(nfsd_cb_setup,
                __field(u32, cl_id)
                __field(unsigned long, authflavor)
                __sockaddr(addr, clp->cl_cb_conn.cb_addrlen)
-               __array(unsigned char, netid, 8)
+               __string(netid, netid)
        ),
        TP_fast_assign(
                __entry->cl_boot = clp->cl_clientid.cl_boot;
                __entry->cl_id = clp->cl_clientid.cl_id;
-               strlcpy(__entry->netid, netid, sizeof(__entry->netid));
+               __assign_str(netid, netid);
                __entry->authflavor = authflavor;
                __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
                                  clp->cl_cb_conn.cb_addrlen)
        ),
        TP_printk("addr=%pISpc client %08x:%08x proto=%s flavor=%s",
                __get_sockaddr(addr), __entry->cl_boot, __entry->cl_id,
-               __entry->netid, show_nfsd_authflavor(__entry->authflavor))
+               __get_str(netid), show_nfsd_authflavor(__entry->authflavor))
 );

> > Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")

Ack.
