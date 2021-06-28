Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF13B5638
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 02:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbhF1AQo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 27 Jun 2021 20:16:44 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50320 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbhF1AQo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 27 Jun 2021 20:16:44 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E3A4F201BD;
        Mon, 28 Jun 2021 00:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624839258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q21UkiFHSFctp9JReAVRFUSObKXc0El7ByDonHRSvzU=;
        b=dP+yxGXDnA3L8mv43PFwVmosKlVuyoe22tQh4jTbDpXvljFJoDDkxNxe0eQLpa1q+X/aih
        VbRiCeH625NlFWuSTjBWSLfFaCOLM1ndBzh3q30nYFg6v8D1VlpGfE0C2/gyp04c8Ago5M
        7gft25LU9EpmFVCowHj9vX5sMhzjQMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624839258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q21UkiFHSFctp9JReAVRFUSObKXc0El7ByDonHRSvzU=;
        b=4JRPKxikKIsx7xxs+2/QWuCC4F1i3XbMvHKeVFeiccaaY460ciRP/Hb+tjHNfRVIq8ruUz
        DiJfLFjhYzkLdZCA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id AA988118DD;
        Mon, 28 Jun 2021 00:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624839258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q21UkiFHSFctp9JReAVRFUSObKXc0El7ByDonHRSvzU=;
        b=dP+yxGXDnA3L8mv43PFwVmosKlVuyoe22tQh4jTbDpXvljFJoDDkxNxe0eQLpa1q+X/aih
        VbRiCeH625NlFWuSTjBWSLfFaCOLM1ndBzh3q30nYFg6v8D1VlpGfE0C2/gyp04c8Ago5M
        7gft25LU9EpmFVCowHj9vX5sMhzjQMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624839258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q21UkiFHSFctp9JReAVRFUSObKXc0El7ByDonHRSvzU=;
        b=4JRPKxikKIsx7xxs+2/QWuCC4F1i3XbMvHKeVFeiccaaY460ciRP/Hb+tjHNfRVIq8ruUz
        DiJfLFjhYzkLdZCA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id NXmDFlgU2WB/FQAALh3uQQ
        (envelope-from <neilb@suse.de>); Mon, 28 Jun 2021 00:14:16 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Dan Carpenter" <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <Anna.Schumaker@Netapp.com>, lkp@intel.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/rfc] NFS: introduce NFS namespaces.
In-reply-to: <202106252106.UEbAG2Yp-lkp@intel.com>
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>,
 <202106252106.UEbAG2Yp-lkp@intel.com>
Date:   Mon, 28 Jun 2021 10:14:13 +1000
Message-id: <162483925301.7211.5330261248734853509@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 25 Jun 2021, Dan Carpenter wrote:
> Hi NeilBrown,
>=20
> url:    https://github.com/0day-ci/linux/commits/NeilBrown/NFS-introduce-NF=
S-namespaces/20210625-093359
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> config: x86_64-randconfig-m001-20210622 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
>=20
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

I assume this only applies if I fix the issue with a separate patch?

>=20
> New smatch warnings:
> fs/nfs/nfs4proc.c:6270 nfs4_init_uniform_client_string() error: we previous=
ly assumed 'clp->cl_namespace' could be null (see line 6247)
>=20
> Old smatch warnings:
> fs/nfs/nfs4proc.c:1382 nfs4_opendata_alloc() error: we previously assumed '=
c' could be null (see line 1350)
>=20
...
> 0575ca34891617 NeilBrown       2021-06-25 @6247  	if (clp->cl_namespace)
>                                                         ^^^^^^^^^^^^^^^^^^^=
^^^
> Checks for NULL

Thanks.  That was suppose to check the first byte of clp->cl_namespace,
not the pointer.

Thanks,
NeilBrown
