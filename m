Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C186FF76B
	for <lists+linux-nfs@lfdr.de>; Thu, 11 May 2023 18:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238673AbjEKQdM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 May 2023 12:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbjEKQdL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 May 2023 12:33:11 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756491BCF
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 09:32:35 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-643a1fed360so5098621b3a.3
        for <linux-nfs@vger.kernel.org>; Thu, 11 May 2023 09:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683822752; x=1686414752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j2NBUWOOR11Ms/2PyvoDCmQ5v0ISgMExdmVp0dYwxIs=;
        b=C7oTW0Zz5xXH199g4i+wko4FpuMlib2Mv0DGdJuj0reCFtwNIU/ydHVWPqjQpkfUbe
         ZgiR4KjlJKcOmNZrs4bsvJ134SBm34Olli34gvXP6XCaiu+FKPC2FEBdAagwlwvHJC7h
         OErMTEZ5w8y9LqkDfhUEjwyZvCygIHC/UYjl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683822752; x=1686414752;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j2NBUWOOR11Ms/2PyvoDCmQ5v0ISgMExdmVp0dYwxIs=;
        b=aCUKTymQH701qdNeFitkyC1ehX6aP1iC0RSTU3v+X/DiUTlCQnXP9e9nivZ3gGMGi1
         SOk7SJzgAmb3Pf2raAailG6yxqu9Oraq+8PfF9BaucEARkISLYMtRveDTrHABH5Ca+Yw
         doXtSC8JZtGRM7VI7bXRKfTM1YXrHGfZgc3VYL2kcr23Upe2YTUE7zoqbK7ayLtGaMR2
         UewVQH2GEY4WsB6/E3M2PxWwstZIuTurQEaodleQ9wT4QinioZXr5AaDVmhIfcBgfzeY
         7xMWnVg5h+MVn9cBtDAgPY8gg029aSqS5LdKLRkENIfWEJyVbM0+tjl+5QZr0IXkfMLG
         yNLw==
X-Gm-Message-State: AC+VfDyDp6wHpqG6H+VBMypg8Pi+CVHbsUzrBYs+fqDrB4ek4TdWBeJ8
        uZMGyyTzDNmV1VEJWWrkN1e9kg==
X-Google-Smtp-Source: ACHHUZ4zSWRkBNeMaRGVVX2fGuE+uy/c5q1dJPkr+NKw2O47VN5LWt0gytxvOCvz7Ee6+cDooJ68eA==
X-Received: by 2002:a05:6a00:23c3:b0:637:f1ae:d3e with SMTP id g3-20020a056a0023c300b00637f1ae0d3emr30009088pfc.25.1683822752594;
        Thu, 11 May 2023 09:32:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i14-20020aa78d8e000000b00646ebc77b1fsm5215220pfr.75.2023.05.11.09.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:32:32 -0700 (PDT)
Date:   Thu, 11 May 2023 09:32:31 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
Message-ID: <202305110927.12508719D2@keescook>
References: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
 <72239648-C807-4CDD-8DA7-18440C83384E@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72239648-C807-4CDD-8DA7-18440C83384E@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 11, 2023 at 02:47:54PM +0000, Chuck Lever III wrote:
> Hello Azeem -
> 
> > On May 10, 2023, at 3:09 PM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote:
> > 
> > strlcpy() reads the entire source buffer first.
> > This read may exceed the destination size limit.
> > This is both inefficient and can lead to linear read
> > overflows if a source string is not NUL-terminated [1].
> > In an effort to remove strlcpy() completely [2], replace
> > strlcpy() here with strscpy().
> > No return values were used, so direct replacement is safe.
> 
> Actually netid should use the __string() and __assign_str()
> macros rather than open-coding a string copy, I think.

Ah, hm, yeah, this is tracing wrappers.

Steve, is there a reason __assign_str() is using "strcpy" and not
strscpy()?

> Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")

Yeah, that works. I was on the fence about adding Fixes for these kinds
of refactoring. Like, it's not really _broken_; we're just trying to
remove the API.

> > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > ---
> > fs/nfsd/trace.h |    2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > index 4183819ea082..9b32cda54808 100644
> > --- a/fs/nfsd/trace.h
> > +++ b/fs/nfsd/trace.h
> > @@ -1370,7 +1370,7 @@ TRACE_EVENT(nfsd_cb_setup,
> > TP_fast_assign(
> > __entry->cl_boot = clp->cl_clientid.cl_boot;
> > __entry->cl_id = clp->cl_clientid.cl_id;
> > - strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> > + strscpy(__entry->netid, netid, sizeof(__entry->netid));
> > __entry->authflavor = authflavor;
> > __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
> >  clp->cl_cb_conn.cb_addrlen)

Leaving code context for Steve to see...

-- 
Kees Cook
