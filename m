Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D133B592D
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Jun 2021 08:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbhF1Gih (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 28 Jun 2021 02:38:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41674 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229911AbhF1Gih (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 28 Jun 2021 02:38:37 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15S6ZIRN008758;
        Mon, 28 Jun 2021 06:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=KqLlKtJ+o4edmSCyLHU/ZGR2WJ/rOsaTk2rjUSSXHSU=;
 b=FALox81FR0AnzUIKtnjfaNh41XP+O2Kh60knae3jw3jQyOY8k+wZQEecpdbtjG3RAdFi
 LTFgE5mOoKxA6n8u2egMiiGBryvSuu+nNll8msGGjB/Q6XXCvCptVLdoToovJLx2DuXv
 QufcXMzkeLMqgvizzgixk8It9uGK4cdhVAHN1uHG1JgPhpmCB3jDy6sqOy3rB4PyWGyB
 lE9BAxo/RGdydnoym7E49tGkye+SrWYDvWoRyfuqNPmUuCpz7rw1BL/LNJ+QB/Y56KnM
 hxN65M1AYmwpamrZKMAT8FXB1pqx1+j7F57xHZ1Jv3Kiqn3Voa8tug1aM9ouWfuD3yCN dA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 39f1hcgfgg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 06:36:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 15S6VjFw042455;
        Mon, 28 Jun 2021 06:36:02 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3020.oracle.com with ESMTP id 39ee0rttyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 06:36:02 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 15S6a1Tg054068;
        Mon, 28 Jun 2021 06:36:01 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 39ee0rttxm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 28 Jun 2021 06:36:01 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 15S6Zsu0018002;
        Mon, 28 Jun 2021 06:35:55 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 27 Jun 2021 23:35:54 -0700
Date:   Mon, 28 Jun 2021 09:35:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     NeilBrown <neilb@suse.de>
Cc:     kbuild@lists.01.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>, lkp@intel.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/rfc] NFS: introduce NFS namespaces.
Message-ID: <20210628063547.GN1983@kadam>
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>
 <202106252106.UEbAG2Yp-lkp@intel.com>
 <162483925301.7211.5330261248734853509@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162483925301.7211.5330261248734853509@noble.neil.brown.name>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-ORIG-GUID: fMeiYCOIBlDxaoyKMysMovAex7b5tmrs
X-Proofpoint-GUID: fMeiYCOIBlDxaoyKMysMovAex7b5tmrs
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jun 28, 2021 at 10:14:13AM +1000, NeilBrown wrote:
> On Fri, 25 Jun 2021, Dan Carpenter wrote:
> > Hi NeilBrown,
> > 
> > url:    https://github.com/0day-ci/linux/commits/NeilBrown/NFS-introduce-NFS-namespaces/20210625-093359 
> > base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
> > config: x86_64-randconfig-m001-20210622 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> I assume this only applies if I fix the issue with a separate patch?

That's stuff the kbuild-bot adds.  I just review the bug report and hit
forward.

regards,
dan carpenter

