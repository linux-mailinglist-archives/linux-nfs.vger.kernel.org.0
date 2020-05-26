Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AD51E2513
	for <lists+linux-nfs@lfdr.de>; Tue, 26 May 2020 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgEZPKZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 26 May 2020 11:10:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728110AbgEZPKY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 26 May 2020 11:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590505822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kbu/whC+mYsh9FeadqG0gLFtDzB4IB8AhQJKwTQ0dQk=;
        b=WCm2fW1Mka0DRCSNFg4RjJZ3oDzxRplz/X2xc6h0zpTriSAYpf1ZswCSBoTUWFIALRgdHk
        6Yk0aHTql/YxqLilQGmFI7dxVf+aSJoVWLu6aEtqrtrwql4KtqrAYKviy/XfoJ7YIS1hXn
        IkVlO2IcvvMwulx4aAlneHHCLSnmV6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-271-IcCnSmnSPVWJHtVAG1Q4iA-1; Tue, 26 May 2020 11:10:15 -0400
X-MC-Unique: IcCnSmnSPVWJHtVAG1Q4iA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC4D3107ACF2
        for <linux-nfs@vger.kernel.org>; Tue, 26 May 2020 15:10:14 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-113-189.phx2.redhat.com [10.3.113.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 384A45C1BB;
        Tue, 26 May 2020 15:10:14 +0000 (UTC)
Subject: Re: [PATCH] nfsdclnts: Add --verbose and --file option.
To:     Kenneth D'souza <kdsouza@redhat.com>, linux-nfs@vger.kernel.org
Cc:     agaikwad@redhat.com
References: <20200525180301.32192-1-kdsouza@redhat.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <62485bef-a53a-edbb-d6d4-915f01298380@RedHat.com>
Date:   Tue, 26 May 2020 11:10:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200525180301.32192-1-kdsouza@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 5/25/20 2:03 PM, Kenneth D'souza wrote:
> Add new option --file to process specific states file,
> provided the info file resides in the same directory as
> states file. If the info file is not valid or present the
> fields would be marked as "N/A".
> 
> --verbose option will be helpful for debugging purpose.
> 
> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
Committed... (tag: nfs-utils-2-4-4-rc6)

steved.
> ---
>  tools/nfsdclnts/nfsdclnts.man | 26 +++++++++++++++++++++++++-
>  tools/nfsdclnts/nfsdclnts.py  | 32 +++++++++++++++++++++++++++-----
>  2 files changed, 52 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/nfsdclnts/nfsdclnts.man b/tools/nfsdclnts/nfsdclnts.man
> index 3701de9a..c7efbd70 100644
> --- a/tools/nfsdclnts/nfsdclnts.man
> +++ b/tools/nfsdclnts/nfsdclnts.man
> @@ -63,6 +63,18 @@ Print hostname of nfs\-client instead of ip-address.
>  Hide the header information.
>  .RE
>  .sp
> +\fB\-v, \-\-verbose\fP
> +.RS 4
> +Verbose operation, show debug messages.
> +.RE
> +.sp
> +\fB\-f, \-\-file\fP
> +.RS 4
> +Instead of processing all client directories under /proc/fs/nfsd/clients, one can provide a specific
> +states file to process. One should make sure that info file resides in the same directory as states file.
> +If the info file is not valid or present the fields would be marked as "N/A".
> +.RE
> +.sp
>  \fB\-h, \-\-help\fP
>  .RS 4
>  Print help explaining the command line options.
> @@ -118,7 +130,19 @@ Inode number | Type   | Access | Deny | ip address            | Client ID
>  .fi
>  .if n .RE
>  .sp
> -\fBnfsdclnts.py \-\-quiet \-\-hostname\fP
> +\fBnfsdclnts \-\-file /proc/fs/nfsd/clients/3/states -t open\fP
> +.RS 4
> +Process specific states file.
> +.RE
> +.sp
> +.if n .RS 4
> +.nf
> +Inode number | Type   | Access | Deny | ip address            | Client ID           | vers | Filename
> +33823232     | open   | r\-     | \-\-   | [::1]:757             | 0xc79a009f5eb65e84  | 4.2  | testfile
> +.fi
> +.if n .RE
> +.sp
> +\fBnfsdclnts \-\-quiet \-\-hostname\fP
>  .RS 4
>  Hide the header information.
>  .RE
> diff --git a/tools/nfsdclnts/nfsdclnts.py b/tools/nfsdclnts/nfsdclnts.py
> index 7370fede..e5f636a2 100755
> --- a/tools/nfsdclnts/nfsdclnts.py
> +++ b/tools/nfsdclnts/nfsdclnts.py
> @@ -54,10 +54,16 @@ def file_to_dict(path):
>                      client_info[key] = val.strip()
>                      # FIXME: There has to be a better way of converting the info file to a dictionary.
>                  except ValueError as reason:
> -                    print('%s' % reason)
> +                    if verbose:
> +                        print('Exception occured, %s' % reason)
> +
> +        if len(client_info) == 0 and verbose:
> +            print("Provided %s file is not valid" %path)
>          return client_info
> +
>      except OSError as reason:
> -        print('%s' % reason)
> +        if verbose:
> +            print('%s' % reason)
>  
>  # this function gets the paths from /proc/fs/nfsd/clients/
>  # returns a list of paths for each client which has nfs-share mounted.
> @@ -159,10 +165,12 @@ def opener(path):
>                      data.append(clientinfo)
>                  return data
>              except:
> -                print("Exception occurred, Please make sure %s is a YAML file" %path)
> +                if verbose:
> +                    print("Exception occurred, Please make sure %s is a YAML file" %path)
>  
>      except OSError as reason:
> -        print('%s' % reason)
> +        if verbose:
> +            print('%s' % reason)
>  
>  def print_cols(argument):
>      title_inode = 'Inode number'
> @@ -204,11 +212,25 @@ def nfsd4_show():
>          help = 'output clients information, --hostname is implied.')
>      parser.add_argument('--hostname', action = 'store_true',
>          help = 'print hostname of client instead of its ip address. Longer hostnames are truncated.')
> +    parser.add_argument('-v', '--verbose', action = 'store_true',
> +        help = 'Verbose operation, show debug messages.')
> +    parser.add_argument('-f', '--file', nargs='+', type = str, metavar='',
> +        help = 'pass client states file, provided that info file resides in the same directory.')
>      parser.add_argument('-q', '--quiet', action = 'store_true',
>          help = 'don\'t print the header information')
>  
>      args = parser.parse_args()
> -    paths = getpaths()
> +
> +    global verbose
> +    verbose = False
> +    if args.verbose:
> +        verbose = True
> +
> +    if args.file:
> +        paths = args.file
> +    else:
> +        paths = getpaths()
> +
>      p = mp.Pool(mp.cpu_count(), init_worker)
>      try:
>          result = p.map(opener, paths)
> 

