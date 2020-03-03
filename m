Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF5E177B33
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Mar 2020 16:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbgCCPzr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Mar 2020 10:55:47 -0500
Received: from fieldses.org ([173.255.197.46]:37226 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730214AbgCCPzr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Mar 2020 10:55:47 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 4A90489A; Tue,  3 Mar 2020 10:55:47 -0500 (EST)
Date:   Tue, 3 Mar 2020 10:55:47 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Stephen Hemminger <stephen@networkplumber.org>
Cc:     trond.myklebust@hammerspace.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Subject: Re: Fw: [Bug 206651] New: kmemleak in rpcsec_gss_krb5
Message-ID: <20200303155547.GD17257@fieldses.org>
References: <20200223195520.0afdad4a@hermes.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223195520.0afdad4a@hermes.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Feb 23, 2020 at 07:55:20PM -0800, Stephen Hemminger wrote:
> During the loading and unloading of the kernel module, kmemleak discovered a
> leak problem. To reproduce this problem, you only need to enable the kmemleak
> option. 
> CONFIG_DEBUG_KMEMLEAK=y 
> CONFIG_DEBUG_KMEMLEAK_EARLY_LOG_SIZE=10000: 
> Then, load and unload the module. 
> modprobe rpcsec_gss_krb5 
> modprobe -r rpcsec_gss_krb5: 
> Repeat this process every 1000 cycles to obtain the leaked information. 
> Repeat the preceding operations for 115 times. The SUnreclaim memory will
> increase by 85 MB. 
> 
> After checking the loading source code of rpcsec_gss_krb5, we find that the
> svcauth_gss_register_pseudoflavor function in the svcauth_gss.c file contains
> the following code segment: 
> 
> ...
>         test = auth_domain_lookup(name, &new->h);
>         if (test != &new->h) { /* Duplicate registration */
>                 auth_domain_put(test);
>                 kfree(new->h.name);
>                 goto out_free_dom;
>         }
>         return 0;
> 
> out_free_dom:
>         kfree(new);
> out:
>         return stat;
> ...
> 
> The structure of new->h.name is dynamically applied by kstrdup. When
> auth_domain_lookup cannot find new->h.name in the hash table, it is added to
> the hash table. 
> 
> When the module is unloaded, the structure in the hash table is not released
> accordingly. As a result, the module is leaked. I modified the gss_mech_free
> function to forcibly release the structure in the hash table. 
> 
> ...
>         for (i = 0; i < gm->gm_pf_num; i++) {
>                 pf = &gm->gm_pfs[i];
> +               struct auth_domain *test;
> +               test = auth_domain_find(pf->auth_domain_name);
> +               if (test != NULL) {
> +                       test->flavour->domain_release(test);
> +               }
>                 kfree(pf->auth_domain_name);
> ...
> 
> Perform the leakage test again. The memory usage of SUnreclaim does not
> increase. 
> 
> I want a complete destructor to free the hash table, not by force.

Thanks!  I'm not sure what the right solution is.  Honestly, maybe just
preventing unloading of these modules--I'm not sure why it's really
needed.

--b.
