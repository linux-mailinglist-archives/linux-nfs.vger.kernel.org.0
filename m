Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD1B4EE10
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2019 19:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfFURpq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 21 Jun 2019 13:45:46 -0400
Received: from fieldses.org ([173.255.197.46]:45110 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbfFURpp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 21 Jun 2019 13:45:45 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id CBC78206B; Fri, 21 Jun 2019 13:45:44 -0400 (EDT)
Date:   Fri, 21 Jun 2019 13:45:44 -0400
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190621174544.GC25590@fieldses.org>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561042275-12723-9-git-send-email-bfields@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I'm not sure who to get review from for this kind of thing.

Kees, you seem to be one of the only people to touch string_helpers.c
at all recently, any ideas?

--b.

On Thu, Jun 20, 2019 at 10:51:07AM -0400, J. Bruce Fields wrote:
> From: "J. Bruce Fields" <bfields@redhat.com>
> 
> I'm exposing some information about NFS clients in pseudofiles.  I
> expect to eventually have simple tools to help read those pseudofiles.
> 
> But it's also helpful if the raw files are human-readable to the extent
> possible.  It aids debugging and makes them usable on systems that don't
> have the latest nfs-utils.
> 
> A minor challenge there is opaque client-generated protocol objects like
> state owners and client identifiers.  Some clients generate those to
> include handy information in plain ascii.  But they may also include
> arbitrary byte sequences.
> 
> I think the simplest approach is to limit to isprint(c) && isascii(c)
> and escape everything else.
> 
> That means you can just cat the file and get something that looks OK.
> Also, I'm trying to keep these files legal YAML, which requires them to
> UTF-8, and this is a simple way to guarantee that.
> 
> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> ---
>  fs/seq_file.c                  | 11 +++++++++++
>  include/linux/seq_file.h       |  1 +
>  include/linux/string_helpers.h |  3 +++
>  lib/string_helpers.c           | 19 +++++++++++++++++++
>  4 files changed, 34 insertions(+)
> 
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index abe27ec43176..04f09689cd6d 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -384,6 +384,17 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
>  }
>  EXPORT_SYMBOL(seq_escape);
>  
> +void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz)
> +{
> +	char *buf;
> +	size_t size = seq_get_buf(m, &buf);
> +	int ret;
> +
> +	ret = string_escape_mem_ascii(src, isz, buf, size);
> +	seq_commit(m, ret < size ? ret : -1);
> +}
> +EXPORT_SYMBOL(seq_escape_mem_ascii);
> +
>  void seq_vprintf(struct seq_file *m, const char *f, va_list args)
>  {
>  	int len;
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index a121982af0f5..5998e1f4ff06 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -127,6 +127,7 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
>  		    unsigned long long v, unsigned int width);
>  
>  void seq_escape(struct seq_file *m, const char *s, const char *esc);
> +void seq_escape_mem_ascii(struct seq_file *m, const char *src, size_t isz);
>  
>  void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
>  		  int rowsize, int groupsize, const void *buf, size_t len,
> diff --git a/include/linux/string_helpers.h b/include/linux/string_helpers.h
> index d23c5030901a..c28955132234 100644
> --- a/include/linux/string_helpers.h
> +++ b/include/linux/string_helpers.h
> @@ -54,6 +54,9 @@ static inline int string_unescape_any_inplace(char *buf)
>  int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  		unsigned int flags, const char *only);
>  
> +int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
> +					size_t osz);
> +
>  static inline int string_escape_mem_any_np(const char *src, size_t isz,
>  		char *dst, size_t osz, const char *only)
>  {
> diff --git a/lib/string_helpers.c b/lib/string_helpers.c
> index 29c490e5d478..9ca19918ca26 100644
> --- a/lib/string_helpers.c
> +++ b/lib/string_helpers.c
> @@ -539,6 +539,25 @@ int string_escape_mem(const char *src, size_t isz, char *dst, size_t osz,
>  }
>  EXPORT_SYMBOL(string_escape_mem);
>  
> +int string_escape_mem_ascii(const char *src, size_t isz, char *dst,
> +					size_t osz)
> +{
> +	char *p = dst;
> +	char *end = p + osz;
> +
> +	while (isz--) {
> +		unsigned char c = *src++;
> +
> +		if (!isprint(c) || !isascii(c) || c == '"' || c == '\\')
> +			escape_hex(c, &p, end);
> +		else
> +			escape_passthrough(c, &p, end);
> +	}
> +
> +	return p - dst;
> +}
> +EXPORT_SYMBOL(string_escape_mem_ascii);
> +
>  /*
>   * Return an allocated string that has been escaped of special characters
>   * and double quotes, making it safe to log in quotes.
> -- 
> 2.21.0
