Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9F8192B84
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 15:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbgCYOxH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 10:53:07 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:44488 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbgCYOxH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 10:53:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PEnCVY123452;
        Wed, 25 Mar 2020 14:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=zAbyJ2Adl64oNbkxQzSsrnmxkJw2yY8FglQ1E9FwStQ=;
 b=yQJWcnOfku9uKxYBkOXUpDtesOWtiEBYp+1Hn3ZsnCMfcihU0S3HrgOE9CJ2R2xHfmMc
 tr3u0Ao+VmlsOjX8PR2UBoVXQJsO6uej3N8QdvLA9O7Rtozbcor1SJ6LaodjwvnICNmm
 R7yuxqbigT1spwuEPU8c7yv8mvNZm/mGB4y9thRh7WIVVDUOINh/TUPUov2whNxRGg2r
 +dOv+2swst5qtmqNcs8a4Zc3UHhkXKIWogzCLc4nvBZSqUgjkZLwgM1/gtDwtMjg3H/W
 ir0ECcbuUvPjrr1+xcIVylcLAHSQovB2JGmxHZGNSBVA+mJjW2vPsX8ylAtFGU7aQjPP 6w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2ywabra6g4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 14:52:51 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02PEnjRm022210;
        Wed, 25 Mar 2020 14:52:50 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 3003ghv4qe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 14:52:50 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02PEqkf5008920;
        Wed, 25 Mar 2020 14:52:46 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 25 Mar 2020 07:52:46 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] SUNRPC: Optimize 'svc_print_xprts()'
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200325070452.22043-1-christophe.jaillet@wanadoo.fr>
Date:   Wed, 25 Mar 2020 10:52:44 -0400
Cc:     trond.myklebust@hammerspace.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Bruce Fields <bfields@fieldses.org>, davem@davemloft.net,
        kuba@kernel.org, gnb@sgi.com, Neil Brown <neilb@suse.de>,
        Tom Tucker <tom@opengridcomputing.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EA5BCDB2-DB05-4B26-8635-E6F5C231DDC6@oracle.com>
References: <20200325070452.22043-1-christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9570 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003250122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9571 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 clxscore=1011 adultscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250122
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Christophe,


> On Mar 25, 2020, at 3:04 AM, Christophe JAILLET =
<christophe.jaillet@wanadoo.fr> wrote:
>=20
> Using 'snprintf' is safer than 'sprintf' because it can avoid a buffer
> overflow.

That's true as a general statement, but how likely is such an
overflow to occur here?


> The return value can also be used to avoid a strlen a call.

That's also true of sprintf, isn't it?


> Finally, we know where we need to copy and the length to copy, so, we
> can save a few cycles by rearraging the code and using a memcpy =
instead of
> a strcat.

I would be OK with squashing these two patches together. I don't
see the need to keep the two changes separated.


> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This patch should have no functionnal change.
> We could go further, use scnprintf and write directly in the =
destination
> buffer. However, this could lead to a truncated last line.

That's exactly what this function is trying to avoid. As part of any
change in this area, it would be good to replace the current block
comment before this function with a Doxygen-format comment that
documents that goal.


> ---
> net/sunrpc/svc_xprt.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
> index df39e7b8b06c..6df861650040 100644
> --- a/net/sunrpc/svc_xprt.c
> +++ b/net/sunrpc/svc_xprt.c
> @@ -118,12 +118,12 @@ int svc_print_xprts(char *buf, int maxlen)
> 	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
> 		int slen;
>=20
> -		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, =
xcl->xcl_max_payload);
> -		slen =3D strlen(tmpstr);
> -		if (len + slen >=3D maxlen)
> +		slen =3D snprintf(tmpstr, sizeof(tmpstr), "%s %d\n",
> +				xcl->xcl_name, xcl->xcl_max_payload);
> +		if (slen >=3D sizeof(tmpstr) || len + slen >=3D maxlen)
> 			break;
> +		memcpy(buf + len, tmpstr, slen + 1);
> 		len +=3D slen;
> -		strcat(buf, tmpstr);

IMO replacing the strcat makes the code harder to read, and this
is certainly not a performance path. Can you drop that part of the
patch?


> 	}
> 	spin_unlock(&svc_xprt_class_lock);
>=20
> --=20
> 2.20.1
>=20

--
Chuck Lever



