Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CA18B9DE
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Mar 2020 16:00:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgCSPAD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 Mar 2020 11:00:03 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59122 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727321AbgCSPAD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 Mar 2020 11:00:03 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JEwlfs164617;
        Thu, 19 Mar 2020 14:59:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=S+s00056yBmxW0bXhrPxXjkIjSTklD49q+1ypVjq9WU=;
 b=ylTuKI6jEOhbvoxWeu+OQ/ASIO19Hc9agFSHtxmcalmVvQywoBVO1y3M/8AEHhgXcliO
 97WGyMFeZIbfXb7Da3Ee+YtoiEpQi8qp3BeLysTiUDwTanQX280QOzXnzKz7pYXIvwqX
 viH7ULIj4tpXALPNUKTGUf33HmSBoT4sqnkAnxgLrWUsD+v4ARDdi0a7MMUtN8xmiLjp
 LrJBFXELhTetihfVrsi87J+tk2ur2XWHwJ6oPZOX1dHsidl06DYb3WpJ1A8orAh/xtt5
 /J30M1MM8wAKgiYA/9MGzYoT1yAruhZfDR7fZ2+cZA3h6mHfd7k3KWB3dL5/PTuXvify sw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2yrq7m8pnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 14:59:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02JEueA8145773;
        Thu, 19 Mar 2020 14:59:58 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2ys8rmbj6e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Mar 2020 14:59:58 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02JExvFs031480;
        Thu, 19 Mar 2020 14:59:57 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Mar 2020 07:59:57 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfsd4: kill warnings on testing stateids with mismatched
 clientids
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <A2752AC8-E6FF-4ED7-86BE-4D64ACE1F7D7@redhat.com>
Date:   Thu, 19 Mar 2020 10:59:56 -0400
Cc:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <88C0AB03-E10D-40D2-BDB6-3185D099C192@oracle.com>
References: <20200319141849.GB1546@fieldses.org>
 <A2752AC8-E6FF-4ED7-86BE-4D64ACE1F7D7@redhat.com>
To:     Benjamin Coddington <bcodding@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190067
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9564 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 priorityscore=1501 clxscore=1011
 malwarescore=0 mlxscore=0 phishscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003190067
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 19, 2020, at 10:30 AM, Benjamin Coddington =
<bcodding@redhat.com> wrote:
>=20
> On 19 Mar 2020, at 10:18, J. Bruce Fields wrote:
>=20
>> From: "J. Bruce Fields" <bfields@redhat.com>
>>=20
>> It's normal for a client to test a stateid from a previous instance,
>> e.g. after a network partition.
>>=20
>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> Thanks!
>=20
> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Applied to nfsd-5.7, thanks all!


> Ben
>=20
>> ---
>> fs/nfsd/nfs4state.c | 9 +--------
>> 1 file changed, 1 insertion(+), 8 deletions(-)
>>=20
>> I'm not a fan of printk's even on buggy client behavior.  I guess it
>> could be a dprintk.  I'm not sure it adds much over information you
>> could get at some other layer, e.g. from a network trace.
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index c1f347bbf8f4..927cfb9d2204 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -5522,15 +5522,8 @@ static __be32 nfsd4_validate_stateid(struct =
nfs4_client *cl, stateid_t *stateid)
>> 	if (ZERO_STATEID(stateid) || ONE_STATEID(stateid) ||
>> 		CLOSE_STATEID(stateid))
>> 		return status;
>> -	/* Client debugging aid. */
>> -	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid)) {
>> -		char addr_str[INET6_ADDRSTRLEN];
>> -		rpc_ntop((struct sockaddr *)&cl->cl_addr, addr_str,
>> -				 sizeof(addr_str));
>> -		pr_warn_ratelimited("NFSD: client %s testing state ID "
>> -					"with incorrect client ID\n", =
addr_str);
>> +	if (!same_clid(&stateid->si_opaque.so_clid, &cl->cl_clientid))
>> 		return status;
>> -	}
>> 	spin_lock(&cl->cl_lock);
>> 	s =3D find_stateid_locked(cl, stateid);
>> 	if (!s)
>> --=20
>> 2.25.1
>=20

--
Chuck Lever



