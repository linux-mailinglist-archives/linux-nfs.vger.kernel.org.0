Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3CA71D01
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Jul 2019 18:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732174AbfGWQgH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Jul 2019 12:36:07 -0400
Received: from fieldses.org ([173.255.197.46]:34234 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbfGWQgH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Jul 2019 12:36:07 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id D88372011; Tue, 23 Jul 2019 12:36:06 -0400 (EDT)
Date:   Tue, 23 Jul 2019 12:36:06 -0400
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     "J . Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/2] nfs4_getfacl: return 1 for unknown option and won't
 use '-?' anymore
Message-ID: <20190723163606.GA16908@fieldses.org>
References: <20190723062713.20570-1-yongcheng.yang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723062713.20570-1-yongcheng.yang@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jul 23, 2019 at 02:27:12PM +0800, Yongcheng Yang wrote:
> The getopt_long() function will return '?' if encounters an option
> character that was not in optstring. So it's impossible to tell the
> option '-?' from an unrecognized option. Don't mention it in Usage.

Thanks, both patches applied.--b.

> 
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
> ---
>  nfs4_getfacl/nfs4_getfacl.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/nfs4_getfacl/nfs4_getfacl.c b/nfs4_getfacl/nfs4_getfacl.c
> index 4df2b04..2f57866 100644
> --- a/nfs4_getfacl/nfs4_getfacl.c
> +++ b/nfs4_getfacl/nfs4_getfacl.c
> @@ -88,10 +88,14 @@ int main(int argc, char **argv)
>  			case 'c':
>  				ignore_comment = 1;
>  				break;
> -			default:
> +			case 'h':
>  				usage(1);
>  				res = 0;
>  				goto out;
> +			case '?':
> +			default:
> +				usage(0);
> +				goto out;
>  		}
>  	}
>  
> @@ -131,7 +135,7 @@ static void usage(int label)
>  {
>  	if (label)
>  		fprintf(stderr, "%s %s -- get NFSv4 file or directory access control lists.\n", execname, VERSION);
> -	fprintf(stderr, "Usage: %s [-R] file ...\n  -H, --more-help\tdisplay ACL format information\n  -?, -h, --help\tdisplay this help text\n  -R --recursive\trecurse into subdirectories\n  -c, --omit-header\tDo not display the comment header (Do not print filename)\n", execname);
> +	fprintf(stderr, "Usage: %s [-R] file ...\n  -H, --more-help\tdisplay ACL format information\n  -h, --help\tdisplay this help text\n  -R --recursive\trecurse into subdirectories\n  -c, --omit-header\tDo not display the comment header (Do not print filename)\n", execname);
>  }
>  
>  static void more_help()
> -- 
> 2.20.1
