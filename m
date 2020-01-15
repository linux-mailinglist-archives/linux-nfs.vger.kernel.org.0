Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E402813C956
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Jan 2020 17:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgAOQ3i (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Jan 2020 11:29:38 -0500
Received: from smtpcmd03116.aruba.it ([62.149.158.116]:48777 "EHLO
        smtpcmd03116.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728899AbgAOQ3h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Jan 2020 11:29:37 -0500
Received: from [192.168.159.128] ([212.103.203.10])
        by smtpcmd03.ad.aruba.it with bizsmtp
        id qgVZ2100Y0DySFo01gVao9; Wed, 15 Jan 2020 17:29:34 +0100
Subject: Re: [nfs-utils PATCH 5/7] rpcgen: rpc_cout: fix potential
 -Wformat-nonliteral warning
To:     linux-nfs@vger.kernel.org, Steve Dickson <SteveD@RedHat.com>
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
 <20200103215039.27471-6-giulio.benetti@benettiengineering.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <dd75fa26-a07a-49fb-ed22-1e60da31c8da@benettiengineering.com>
Date:   Wed, 15 Jan 2020 17:29:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200103215039.27471-6-giulio.benetti@benettiengineering.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1579105774; bh=oFCzMse9LoX8UOQcqQZ2Ox2vrp+f92Of5Z80w6VAk8w=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=mrXMPqKx/cJfHZKpy4+oTiBM6Vz8tLA8ee7VQhXKPwVGk0m8sbV0PbC8Xgi3JGApb
         bG7VcEQnLyoLsEp0tZgjSd4yXjmX8AqJ8Z85y1VcJlq5muQGEM9yFCWVQqDTle7W8L
         xYWGZ/fh7BtorRS+psFghfbx2DjIgsnzFWIqVPHrfwLW8nkW8u4hlF+gdD6TtYjsuo
         6D7iSTJx1255XPop5Fmy0ZWtOalFtqyFyS/5hVIwSZGTR0WFIE6ngzuf/mB11aBGOb
         u/j6iIlES5UuSe5rseIufnsQAQ7LyJfnet1zOBYUD5MjoTvFOgMFojEAiUJyIYjcN6
         3hQ4q9cWz0K7w==
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

you've missed this patch while applying the series. Can you please 
commit it?

Thank you
Kind regards
-- 
Giulio Benetti
Benetti Engineering sas

On 1/3/20 10:50 PM, Giulio Benetti wrote:
> format and vecformat must be declared as "char * const" to be really
> treated as constant when building with -Werror=format-nonliteral,
> otherwise compiler will consider them subject to change throughout the
> function.
> 
> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> ---
>   tools/rpcgen/rpc_cout.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/rpcgen/rpc_cout.c b/tools/rpcgen/rpc_cout.c
> index f806a86a..df2609c4 100644
> --- a/tools/rpcgen/rpc_cout.c
> +++ b/tools/rpcgen/rpc_cout.c
> @@ -319,8 +319,8 @@ emit_union(definition *def)
>     case_list *cl;
>     declaration *cs;
>     char *object;
> -  char *vecformat = "objp->%s_u.%s";
> -  char *format = "&objp->%s_u.%s";
> +  char * const vecformat = "objp->%s_u.%s";
> +  char * const format = "&objp->%s_u.%s";
>   
>     print_stat(1,&def->def.un.enum_decl);
>     f_print(fout, "\tswitch (objp->%s) {\n", def->def.un.enum_decl.name);
> 

