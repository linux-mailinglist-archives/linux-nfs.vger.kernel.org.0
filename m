Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35B63E5D
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Jul 2019 01:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbfGIXdy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Jul 2019 19:33:54 -0400
Received: from fieldses.org ([173.255.197.46]:52792 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbfGIXdy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 9 Jul 2019 19:33:54 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A988D1C9D; Tue,  9 Jul 2019 19:33:53 -0400 (EDT)
Date:   Tue, 9 Jul 2019 19:33:53 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Joe Perches <joe@perches.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] nfsd: Fix misuse of strlcpy
Message-ID: <20190709233353.GA1536@fieldses.org>
References: <cover.1562283944.git.joe@perches.com>
 <b51141d12de77eb22101e81f9eb2c9cc44104d7a.1562283944.git.joe@perches.com>
 <20190709031404.GD14439@fieldses.org>
 <9a5dedb0c9221743033f28974820e8dd724e388d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a5dedb0c9221743033f28974820e8dd724e388d.camel@perches.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 08, 2019 at 10:40:50PM -0700, Joe Perches wrote:
> On Mon, 2019-07-08 at 23:14 -0400, J. Bruce Fields wrote:
> > On Thu, Jul 04, 2019 at 04:57:48PM -0700, Joe Perches wrote:
> > > Probable cut&paste typo - use the correct field size.
> > 
> > Huh, that's been there forever, I wonder why we haven't seen crashes?
> > Oh, I see, name and authname both have the same size.
> > 
> > Anyway, makes sense, thanks.  Will apply for 5.3.
> > 
> > (Unless someone else is getting this; I didn't get copied on the rest of
> > the series.)
> 
> It's generally hard to cc everyone on treewide fixes like this.
> 
> There's no good mechanism I know of.
> vger mailing lists reject emails with too many addressees.

Yeah.  I guess what I don't understand is why this patch is part of a
series at all.  It makes me wonder if there's some dependency I missed
or if the 0/8 mail actually asked somebody else to apply it.

Whatever, I guess I'm being silly, it clearly stands alone.  Applying
for 5.3.

> Do you have an opinion on adding the stracpy macro which
> could avoid many of these defects?

I don't have an opinion.

--b.


> ---
>  include/linux/string.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 4deb11f7976b..ef01bd6f19df 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -35,6 +35,22 @@ ssize_t strscpy(char *, const char *, size_t);
>  /* Wraps calls to strscpy()/memset(), no arch specific code required */
>  ssize_t strscpy_pad(char *dest, const char *src, size_t count);
>  
> +#define stracpy(to, from)					\
> +({								\
> +	size_t size = ARRAY_SIZE(to);				\
> +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> +								\
> +	strscpy(to, from, size);				\
> +})
> +
> +#define stracpy_pad(to, from)					\
> +({								\
> +	size_t size = ARRAY_SIZE(to);				\
> +	BUILD_BUG_ON(!__same_type(typeof(*to), char));		\
> +								\
> +	strscpy_pad(to, from, size);				\
> +})
> +
>  #ifndef __HAVE_ARCH_STRCAT
>  extern char * strcat(char *, const char *);
>  #endif
> 
> 
