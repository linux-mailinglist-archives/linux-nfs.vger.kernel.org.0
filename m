Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB79D701AE0
	for <lists+linux-nfs@lfdr.de>; Sun, 14 May 2023 01:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjEMXqQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 13 May 2023 19:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjEMXqP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 13 May 2023 19:46:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8780D1FD4;
        Sat, 13 May 2023 16:46:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1930560EEA;
        Sat, 13 May 2023 23:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F43C433D2;
        Sat, 13 May 2023 23:46:11 +0000 (UTC)
Date:   Sat, 13 May 2023 19:46:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Azeem Shaikh <azeemshaikh38@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] NFSD: Replace all non-returning strlcpy with strscpy
Message-ID: <20230513194609.1b3121f6@rorschach.local.home>
In-Reply-To: <202305110927.12508719D2@keescook>
References: <20230510220952.3507366-1-azeemshaikh38@gmail.com>
        <72239648-C807-4CDD-8DA7-18440C83384E@oracle.com>
        <202305110927.12508719D2@keescook>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 11 May 2023 09:32:31 -0700
Kees Cook <keescook@chromium.org> wrote:

> On Thu, May 11, 2023 at 02:47:54PM +0000, Chuck Lever III wrote:
> > Hello Azeem -
> >   
> > > On May 10, 2023, at 3:09 PM, Azeem Shaikh <azeemshaikh38@gmail.com> wrote:
> > > 
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > > No return values were used, so direct replacement is safe.  
> > 
> > Actually netid should use the __string() and __assign_str()
> > macros rather than open-coding a string copy, I think.  
> 
> Ah, hm, yeah, this is tracing wrappers.
> 
> Steve, is there a reason __assign_str() is using "strcpy" and not
> strscpy()?

Yes. Because __assign_str() predates strscpy() ;-)

Note, to use __assign_str(), you first need to do __string(), which
will do (in all that TRACE_EVENT() macro magic):

#undef __dynamic_array
#define __dynamic_array(type, item, len)                                \
        __item_length = (len) * sizeof(type);                           \
        __data_offsets->item = __data_size +                            \
                               offsetof(typeof(*entry), __data);        \
        __data_offsets->item |= __item_length << 16;                    \
        __data_size += __item_length;

#undef __string
#define __string(item, src) __dynamic_array(char, item,                 \
                    strlen((src) ? (const char *)(src) : "(null)") + 1)

In order to save a dynamic size string (or array) it must first
calculate that size with a strlen(). If the source is not terminated,
then this will crash there regardless.

The strlen() is to know how much to allocate on the ring buffer, then a
copy is done to copy it. I guess you could be worried about the size
"changing" between the time it is allocated and copied. If that's the
concern then we could do a length copy.

> 
> > Fixes: 3c92fba557c6 ("NFSD: Enhance the nfsd_cb_setup tracepoint")  
> 
> Yeah, that works. I was on the fence about adding Fixes for these kinds
> of refactoring. Like, it's not really _broken_; we're just trying to
> remove the API.
> 
> > > Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
> > > ---
> > > fs/nfsd/trace.h |    2 +-
> > > 1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
> > > index 4183819ea082..9b32cda54808 100644
> > > --- a/fs/nfsd/trace.h
> > > +++ b/fs/nfsd/trace.h
> > > @@ -1370,7 +1370,7 @@ TRACE_EVENT(nfsd_cb_setup,
> > > TP_fast_assign(
> > > __entry->cl_boot = clp->cl_clientid.cl_boot;
> > > __entry->cl_id = clp->cl_clientid.cl_id;
> > > - strlcpy(__entry->netid, netid, sizeof(__entry->netid));
> > > + strscpy(__entry->netid, netid, sizeof(__entry->netid));
> > > __entry->authflavor = authflavor;
> > > __assign_sockaddr(addr, &clp->cl_cb_conn.cb_addr,
> > >  clp->cl_cb_conn.cb_addrlen)  
> 
> Leaving code context for Steve to see...
> 

The above isn't __assign_str(). Not exactly sure what you want me to
see here.

-- Steve
