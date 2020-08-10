Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90945240CE7
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 20:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgHJSVm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 14:21:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54096 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727982AbgHJSVl (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 14:21:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AIGd23034087;
        Mon, 10 Aug 2020 18:21:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=0u7m/XPZTsYx/mE3Doao7DlskDU9ok11KT8w6IwQTvk=;
 b=cXcjfXfqqIYxmPmGr1T8E7Vx+7FGZr7GKIAcs4i+QyX+M0MQAGuLKf3zSFh71Pm8ngqn
 Y8Qgr/n/tcPsFuQonSU2ysytr15NdcywwR9rfPrjs/P1OTrC/+np93C11L/UxVReAEG6
 x0aulq+JyoY4ueRlFbg007aTK40WONQX4TET5vFp9hnc3m6kdBAIaiSAdRFQxyj9YqBu
 e/swTTm6F4X+0p4J2ErhiM5EjddKYO/z8Rtj1aJCi0Xwd2I3WgUMlGHVAqR1zyBFzklJ
 mA17mL8j0fvcTsniGoIKzm1TltOFlYAEAHL8hrTPMbI03wh3TBHPLRUhJ4EzuPI/gp5n YQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32smpn84xs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 18:21:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AIIM1a081033;
        Mon, 10 Aug 2020 18:21:37 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32t5yx7pvu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 18:21:37 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07AILZjV020983;
        Mon, 10 Aug 2020 18:21:36 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 18:21:35 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200809212531.GB29574@fieldses.org>
Date:   Mon, 10 Aug 2020 14:21:34 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org> <20200809212531.GB29574@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100127
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 9, 2020, at 5:25 PM, Bruce Fields <bfields@fieldses.org> wrote:
>=20
> On Sun, Aug 09, 2020 at 04:27:39PM -0400, Bruce Fields wrote:
>> On Sun, Aug 09, 2020 at 01:11:36PM -0400, Chuck Lever wrote:
>>> Hi Bruce-
>>>=20
>>> I noticed that one of my tests takes about 4x longer on NFSv4.0 than
>>> it does on NFSv3 or NFSv4.[12]. As an initial stab at the cause, I'm
>>> seeing lots of these:
>>=20
>> Oops, looks obvious in retrospect, but I didn't think of it.
>>=20
>> In the 4.1+ case, sessions mean that we know which client every
>> operation comes from.
>>=20
>> In the 4.0 case that only works for operations that take a stateid or
>> something else we can link back to a client.
>>=20
>> That means in the 4.0 case delegations are less useful, since they =
have
>> to be broken on any (non-truncating) setattr, any link/unlink, etc.,
>> even if the operation comes from the same client--the server doesn't
>> have a way to know that.
>>=20
>> Maybe the change to give out read delegations even on write opens
>> probably just isn't worth in the 4.0 case.
>=20
> Untested, but maybe this?--b.
>=20
> commit 2102ac0b68f3
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Sun Aug 9 17:11:59 2020 -0400
>=20
>    nfsd4: don't grant delegations on 4.0 create opens
>=20
>    Chuck reported a major slowdown running the git regression suite =
over
>    NFSv4.0.
>=20
>    In the 4.0 case, the server has no way to identify which client =
most
>    metadata-modifying operations come from.  So, for example, the =
common
>    pattern of a a setattr is likely to result in an immediate break in =
the
>    4.0 case.
>=20
>    It's probably not worth giving out delegations on 4.0 creates.
>=20
>    Reported-by: Chuck Lever <chuck.lever@oracle.com>
>    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fdba971d06c3..ce2d052b3f64 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5096,6 +5096,16 @@ nfs4_open_delegation(struct svc_fh *fh, struct =
nfsd4_open *open,
> 				goto out_no_deleg;
> 			if (!cb_up || !(oo->oo_flags & =
NFS4_OO_CONFIRMED))
> 				goto out_no_deleg;
> +			/*
> +			 * In the absence of sessions, most operations
> +			 * that modify metadata (like setattr) can't
> +			 * be linked to the client sending them, so
> +			 * will result in a delegation break.  That's
> +			 * especially likely for create opens:
> +			 */
> +			if (clp->cl_minorversion =3D=3D 0 &&
> +					open->op_create =3D=3D =
NFS4_OPEN_CREATE)
> +				goto out_no_deleg;
> 			break;
> 		default:
> 			goto out_no_deleg;


For these results I've switched to sec=3Dsys so the test completes =
faster.

NFSv3/sys: 953.37user 5101.96system 14:13.78elapsed 709%CPU =
(0avgtext+0avgdata 107160maxresident)k

NFSv4.1/sys: 953.64user 5202.27system 17:54.51elapsed 572%CPU =
(0avgtext+0avgdata 107204maxresident)k


NFSv4.0/sys unpatched: 965.44user 5406.75system 36:10.72elapsed 293%CPU =
(0avgtext+0avgdata 107252maxresident)k

NFSv4.0/sys with fix: 968.38user 5359.18system 30:50.38elapsed 341%CPU =
(0avgtext+0avgdata 107140maxresident)k


--
Chuck Lever



