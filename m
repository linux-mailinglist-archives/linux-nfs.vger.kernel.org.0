Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB41D270404
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Sep 2020 20:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIRSbm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Sep 2020 14:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29294 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgIRSbl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Sep 2020 14:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600453900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=phWe9WY+7zo9jat4gc6JxkV4EvNrdrtfXImt6Yr8ePs=;
        b=PFekEQvUdeVNIjNv79TmDHXZLy371DhO+gOH9WIgMKx0Wd1d5xv1PUPUDqKLNGabxhvu2B
        D8EbggQj6iCK3akpLJJklTNOVBZ1+ItrAqzsM5lm4JBF9wf+jRViTQvK8uck+unKeOe9xe
        cwEUa2CK2yuQ/BHgchE57hV5kFr+nDE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-C4xijL-oPRuXSSWCKGqoMw-1; Fri, 18 Sep 2020 14:31:38 -0400
X-MC-Unique: C4xijL-oPRuXSSWCKGqoMw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9EBF800050;
        Fri, 18 Sep 2020 18:31:37 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-247.phx2.redhat.com [10.3.112.247])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A64B273660;
        Fri, 18 Sep 2020 18:31:37 +0000 (UTC)
Subject: Re: [PATCH] nfsidmap:umich_ldap return success only if attributes are
 found in ldap resp.
To:     Srikrishan Malik <srikrishanmalik@gmail.com>,
        linux-nfs@vger.kernel.org
References: <20200911142202.84696-1-srikrishanmalik@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <89e9790c-d2fc-6b2f-cc2a-6e036a75419f@RedHat.com>
Date:   Fri, 18 Sep 2020 14:31:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911142202.84696-1-srikrishanmalik@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 9/11/20 10:22 AM, Srikrishan Malik wrote:
> Return ENOENT if the UID/GID attributes are not found in ldap response.
> 
> Signed-off-by: Srikrishan Malik <srikrishanmalik@gmail.com>
Committed... (tag nfs-utils-2-5-2-rc5)

steved.

> ---
>  support/nfsidmap/umich_ldap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/support/nfsidmap/umich_ldap.c b/support/nfsidmap/umich_ldap.c
> index c475d379..1aa2af49 100644
> --- a/support/nfsidmap/umich_ldap.c
> +++ b/support/nfsidmap/umich_ldap.c
> @@ -643,6 +643,7 @@ umich_name_to_ids(char *name, int idtype, uid_t *uid, gid_t *gid,
>  				goto out_memfree;
>  			}
>  			*uid = tmp_uid;
> +			err = 0;
>  		} else if (strcasecmp(attr_res, ldap_map.NFSv4_gid_attr) == 0) {
>  			tmp_g = strtoul(*idstr, (char **)NULL, 10);
>  			tmp_gid = tmp_g;
> @@ -656,6 +657,7 @@ umich_name_to_ids(char *name, int idtype, uid_t *uid, gid_t *gid,
>  				goto out_memfree;
>  			}
>  			*gid = tmp_gid;
> +			err = 0;
>  		} else {
>  			IDMAP_LOG(0, ("umich_name_to_ids: received attr "
>  				"'%s' ???", attr_res));
> @@ -667,7 +669,6 @@ umich_name_to_ids(char *name, int idtype, uid_t *uid, gid_t *gid,
>  		ldap_value_free(idstr);
>  	}
>  
> -	err = 0;
>  out_memfree:
>  	ber_free(ber, 0);
>  out_unbind:
> 

