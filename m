Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 006D0241149
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Aug 2020 22:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHJUBR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Aug 2020 16:01:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:35088 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727817AbgHJUBR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Aug 2020 16:01:17 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AJvukg089031;
        Mon, 10 Aug 2020 20:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=AgiULN68C/ENFrujzbXVzUu3mRx4MdbdYIoVLTwpA08=;
 b=GityR1plVzsnq9nNs9YBp3/BzBUKO93g6T4pZJMFyPNPlxLZQqHRvRzITYPJq0B4eA0Z
 wL0KOF1To7VA8Yj8j46/Yj+EwSdTwb4kv2eVhV2/60qZrw1w6L5QG30/Sxw4k9KWbWOc
 bA2uPGbzACB74CpUPT4Oijp/whoFqc03InWqRUjhbeNlRtgNYVp5IEvZaEfs7YDwDXkt
 PhQq53CObDl4zqvQkC4stCmt4gRCg4Pys2mwOk6UsytsksTXPI3I8SOuUezxGy9aydiO
 uLfA+IO0loqo/TdiWcVlbzoveIOKlgH01CQSQLgaa9ChhpjycvpmORZZ8paBhiNt+0zR DQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 32t2ydf2jv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Aug 2020 20:01:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07AJvPml063909;
        Mon, 10 Aug 2020 20:01:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 32u3h08sq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Aug 2020 20:01:15 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07AK1E8q011908;
        Mon, 10 Aug 2020 20:01:14 GMT
Received: from anon-dhcp-152.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Aug 2020 20:01:01 +0000
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: still seeing single client NFS4ERR_DELAY / CB_RECALL
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20200810190729.GB13266@fieldses.org>
Date:   Mon, 10 Aug 2020 16:01:00 -0400
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <00CAA5B7-418E-4AB5-AE08-FE2F87B06795@oracle.com>
References: <139C6BD7-4052-4510-B966-214ED3E69D61@oracle.com>
 <20200809202739.GA29574@fieldses.org> <20200809212531.GB29574@fieldses.org>
 <227E18E8-5A45-47E3-981C-549042AFB391@oracle.com>
 <20200810190729.GB13266@fieldses.org>
To:     Bruce Fields <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9709 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008100136
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 10, 2020, at 3:07 PM, Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> Thanks for the test results:
>=20
> On Mon, Aug 10, 2020 at 02:21:34PM -0400, Chuck Lever wrote:
>> For these results I've switched to sec=3Dsys so the test completes =
faster.
>>=20
>> NFSv3/sys: 953.37user 5101.96system 14:13.78elapsed 709%CPU =
(0avgtext+0avgdata 107160maxresident)k
>>=20
>> NFSv4.1/sys: 953.64user 5202.27system 17:54.51elapsed 572%CPU =
(0avgtext+0avgdata 107204maxresident)k
>>=20
>> NFSv4.0/sys unpatched: 965.44user 5406.75system 36:10.72elapsed =
293%CPU (0avgtext+0avgdata 107252maxresident)k
>>=20
>> NFSv4.0/sys with fix: 968.38user 5359.18system 30:50.38elapsed =
341%CPU (0avgtext+0avgdata 107140maxresident)k
>=20
> Well, that didn't work!
>=20
> So maybe it's write opens that are the problem in this case.  The =
below
> should mostly revert to pre-94415b06eb8a behavior in the 4.0 case, so =
if
> this doesn't fix it then I was wrong about the cause....
>=20
> --b.
>=20
> commit 0e94ee0b6f11
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
>    pattern of an create or write open followed by a setattr is likely =
to
>    result in an immediate break in the 4.0 case.
>=20
>    It's probably not worth giving out delegations on 4.0 write or =
create
>    opens.
>=20
>    Reported-by: Chuck Lever <chuck.lever@oracle.com>
>    Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index fdba971d06c3..0d51d1751592 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -5096,6 +5096,19 @@ nfs4_open_delegation(struct svc_fh *fh, struct =
nfsd4_open *open,
> 				goto out_no_deleg;
> 			if (!cb_up || !(oo->oo_flags & =
NFS4_OO_CONFIRMED))
> 				goto out_no_deleg;
> +			if (clp->cl_minorversion)
> +				break;
> +			/*
> +			 * In the absence of sessions, most operations
> +			 * that modify metadata (like setattr) can't
> +			 * be linked to the client sending them, so
> +			 * will result in a delegation break.  That's
> +			 * especially likely for write and create opens:
> +			 */
> +			if (open->op_share_access & =
NFS4_SHARE_ACCESS_WRITE)
> +				goto out_no_deleg;
> +			if (open->op_create =3D=3D NFS4_OPEN_CREATE)
> +				goto out_no_deleg;
> 			break;
> 		default:
> 			goto out_no_deleg;

Roughly the same result with this patch as with the first one. The
first one is a little better. Plus, I think the Solaris NFS server
hands out write delegations on v4.0, and I haven't heard of a
significant issue there. It's heuristics may be different, though.

So, it might be that NFSv4.0 has always run significantly slower. I
will have to try a v5.4 or older server to see.

Also, instead of timing, I should count forward channel RPCs and
callbacks, or perhaps the number of DELAY responses.

Don't touch that dial!


--
Chuck Lever



