Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3550342441D
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Oct 2021 19:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhJFR3S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Oct 2021 13:29:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47244 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238289AbhJFR3R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Oct 2021 13:29:17 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 196GxCOx025516;
        Wed, 6 Oct 2021 17:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=VbOZkm9cDpjG0HiAx2Q+/+S8i4bmQEwp9l75XgXpSH8=;
 b=axsk8iU9uXKNeKlrwBqXHLrAp7X5rENI4S5CeOA00nzDqk+qepdxDZ0OYgkrOhAYQmpK
 B9cwjMCoZFSx++aSX1RiqPvDl+IZBcnQW3C6lVoUJT6YkQxDT+LWYO3j52r3XLLPLy9l
 7RKClJivvoLxzlaufUq/cG6iavMvUJZ5EudpY19rzybSbPhqFWP9NAwarBZ+YIDvYKAx
 m4GppGGT9NvHb8TOZ305bizLM7sVMGB3XgzNX1nNJs6+bSnEGU1TfTdjeItEQCBqT1f6
 qFpHP9I3Vat+nWb7MbPqClSLy0oiGSSHjNhanPFnOyFvojyg0pxbnCniIVfGOEb5M/AL bg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bh3y5dqdr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 17:27:17 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 196HEkgV091913;
        Wed, 6 Oct 2021 17:27:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by userp3020.oracle.com with ESMTP id 3bf16vfqc3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Oct 2021 17:27:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HZvBZPkhIYMykLHjAHXoZzBLV687KT7435lwilZ2Az8+lmc4ZxAq7whgtb3CCCKSewngeTWWVoy4i7+8VJogySisqw+vETHxKaN1vhHlDAqhw/Rl8V6FIkHtnOSiDYVg9VYTJoOPIMgtogIUXY/KNrag1vIYsVUBIQH9mywkY5JkNLqqen/WZWIlPP10gszgmXhOjLnK4ied1gsHPGcJWqdofDrc5vxMGZnyODDabIA0vpMLJNaSj7mbNGMsqrAts7/6NrVV9FKgNn8+8WOARTDpKW8NiPYRnnQIOklZVQi43eud8Wa1TfWvx+lyCu/HpcSTj+CXR+ONGrbUaC7arw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbOZkm9cDpjG0HiAx2Q+/+S8i4bmQEwp9l75XgXpSH8=;
 b=eZ1rqYQ+prgy4tPDRN/rPxnZZEbeMPYo0O6+bv2tWs9rmbrRUNJiKEJA4w4SrFu0W18MgJc9Y4HU2CoJdAE7xOCogok8NxD7ZYadRsxjPJ5W7Jkqodpkj+0GovqOUA0GPlTo4TdzZ5tVaB4yUkrz0wP2eB876Q80LilodldBr0+75GluiCT5X8KenGUIoIBMVgvWFFPc+5HHQji6w1d93OoXr/EedPR9Vbz5SggMWKeYdMPWYMt244OPGEdvHc028Mh2k3UfjLw3+PuY3bnxefVwk47qkyqqnhqUQnYjQCN4FgzCLk0KempCYvoCRFglVig2uZfhL5LPD4ctIYqDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbOZkm9cDpjG0HiAx2Q+/+S8i4bmQEwp9l75XgXpSH8=;
 b=YvxHsGw4r6S5jhupUMXPYAsmP6MU0PnOu8FEzhiY0Mroj8+OPUYr3PVnUtvWHHyaHf9wNmUKIuedAdaOHV8Pwn0TkSHlqyLAfWFxaaSHDqtEmMBQDVVgp7vIX+PKf8I0hjTFbPIYEJJOUqpvuaDja8iy1twsBW9mKMfxentxo84=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18; Wed, 6 Oct
 2021 17:27:11 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4566.022; Wed, 6 Oct 2021
 17:27:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Benjamin Coddington <bcodding@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Keep existing listeners on portlist error
Thread-Topic: [PATCH v2] NFSD: Keep existing listeners on portlist error
Thread-Index: AQHXutaGygzc3bPaZEC+huYHtIMXaKvGORwA
Date:   Wed, 6 Oct 2021 17:27:10 +0000
Message-ID: <D6AB2AA2-CBED-45EE-90C3-7D4F4FFD8540@oracle.com>
References: <45b916f1aa3fb7c059a574f61188a8f2f615410e.1633529847.git.bcodding@redhat.com>
 <547ee3794ac9678bc20ccb6ec35ba0fca5fe92f2.1633540771.git.bcodding@redhat.com>
In-Reply-To: <547ee3794ac9678bc20ccb6ec35ba0fca5fe92f2.1633540771.git.bcodding@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8b3b5069-8fca-47f6-4d34-08d988ee87b6
x-ms-traffictypediagnostic: SJ0PR10MB4525:
x-microsoft-antispam-prvs: <SJ0PR10MB452567833CB3583961D1438093B09@SJ0PR10MB4525.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9ramSn6mRse47QQqsQdFlO3szTQZAX6gZDYLvU/YdwjcC+SiEXldNfmWCtcUpsrkNpEX+Vl7Uyo26/RKgwuiSVVKVJvub8jf6/R1xAm0QeAxWnzwtGgBxF1ndDUqP5fO7P8+G9zzuqWW5HvgH38lz18MytYaS69kJKBIratvoeSid5gRtG3Xt7xcfTTR+lG4R2h+kT2+/ZufUekIXg1G7MKzUQ+kJJy1VZJSbbicYSb0BkPj28eFwlB0dr6X8wFtvaDeJ09GHHfDUin3xZU3ed/t3mcsfTR1MvpPuG/c4uMmTo6ZWx3Yh3qnRSrfPybS+RkU7LAkKubcwle12Ye7iV2w/VqCreZXYr7YDk1pw1YsU/3FNr8bpudW+hE+KIbjEuS+ERBGo9K6124FcmBt37Hy2Rx6RUj4LHeDEgplNxioZmR0AZxpmblg4eU2Zbejrim+GG6aTadlfoO9zZySgLm7zswEEP2xn41OUQ3nwdqng/vW1c0/BzDqWL28aH5zsKWF7aAQ848DcuPOcjAh0QulA+J4+UKJ91NtUNH8EvOlHgfG3fSnY6iqnMT5J2npiX339YIpqzmKZaDVrxGmrwzhVXtAZu7arLd3Xp40PaLfahzCe2Ms8l2C833jFTSIQamaB1/X8I1FkV/wTHimfPU7+5t4s0Zg49kIweg7+xbzTmdYBNpPR/JjCjHxn5TTW4yGtpBPgSX5qUyTc8JmHoMaF/i6Yq3DFmIxSKTxLh0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(76116006)(66556008)(71200400001)(64756008)(5660300002)(36756003)(6506007)(66446008)(91956017)(66476007)(53546011)(66946007)(26005)(186003)(54906003)(316002)(6486002)(6916009)(2616005)(86362001)(38070700005)(33656002)(8936002)(38100700002)(122000001)(4326008)(8676002)(508600001)(83380400001)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IuYTbKdYqDgETmV1iuJiQTVDOIfUkzyNjmpOEL/D2gUOloEm15HM1q/DLU4E?=
 =?us-ascii?Q?MLscQ4ZOinjn6xR3OcJsNMrrJtsmhlUAwnFOwKuti2HgtJAKRz974wcDT8KX?=
 =?us-ascii?Q?0vBy+IsATiDeKJeO9opnmrWT4WA1jIJ2j3L7w9QSAybtIyIxMoGoeqgukIU5?=
 =?us-ascii?Q?9Zt1N9PKGKyct/KKV5A/466FJpwtdP83untzbeQq7PEOE+KTSJ7pPnpzjQGs?=
 =?us-ascii?Q?6r5WsRCzBmvMoyaZZzLyIKthHGHEio8qHTSfsLX0CiT81XcGGapna92Kjv8A?=
 =?us-ascii?Q?NdEEbfUopi5tB0BOAs6WzSrWO/J1rUhdqLlCSg8BAHB84byBcneJdFrtpJun?=
 =?us-ascii?Q?K7STzg9SCRFBLxLbIgA2dvVjk04TQvhqdkWdmAPs6d4bl56cCzWXHOJstJfV?=
 =?us-ascii?Q?jUv2jCwNKjO5rYShUslg7H0CcsgbUOo0gGOGeCl7E4ywHBp5DIbCZPkwVCe5?=
 =?us-ascii?Q?gNLs9zV7dWtcfFZsxXjbv+m4L1+ecIPdjQop0ttD/mFM4jgNr/nrO7H/jduN?=
 =?us-ascii?Q?5roSM0WSGDqtBUGBHXfTGOeSxe3G/I8KBh8PV42PC4a04X97OUU8VWmNpvcM?=
 =?us-ascii?Q?Wir+x3Zg4t10P2jI215Oo8+B146Ffd2etYiOEpHcA9nfl0GsC4i0NlR1KMFX?=
 =?us-ascii?Q?Zz+SCDPy3nJ6g6XJW76V7i1YDNMQnB18Bfaqh+GsvP2OL40FljtlVVlztHvm?=
 =?us-ascii?Q?IdOO1md9aHLaaZjW1zGNJKry4xp5Cxlpb8uW/WJGmaikTR0ZsU8xKEJsUlAg?=
 =?us-ascii?Q?YyqZiVcMzyLSxrCxdozbaJ636OM+nkz9YMdW9DtQtzt88fy9AgaAXm6azIl3?=
 =?us-ascii?Q?kxC/A3558HNgtk5Mm+Bly8wHJ4GU5JqRjsdimY6Uf2hv3gF0VWO0M2tg//5a?=
 =?us-ascii?Q?DiQs8pKC4tDRic0GPtH92DYfN3R55uc2bq4rgGWATP1lUzIRGJ2TcK4zabwB?=
 =?us-ascii?Q?CyYzjzLAr/sbVKEQJI6j7Zqed45Ji5MQKCgF2IBzDxe+Gb29D2UVgoaXdhBu?=
 =?us-ascii?Q?ztjygroemg9vcCh4wQioxisNNIuYXHwqAm3RQqaAJyqjDVg+MEBv2PBt1nWz?=
 =?us-ascii?Q?N/Ev5yfYJI3olZEMeAtu3CbMM47/7cDHJIgbuE9iyFBDbVcvxA3+U1gDIced?=
 =?us-ascii?Q?iIp506oE/czQEJHTvnCjJFEx3F3rpOJ/el/7TO1w/Mw+7GiTlkgXvRSXUANx?=
 =?us-ascii?Q?6CHe9PzAFI6BaZ1p+VK1UoPOX+mTI9yJC8ZlvhFAt2g6xIom/pjCJ7qtLMcN?=
 =?us-ascii?Q?gSLY5GcUlyA6ldYxrkewyChCyuLyQKUda12tJo2cUJu2eAyVXngJsJuPc22q?=
 =?us-ascii?Q?FCk+i7Bxr4MzZ4JuoHRT783m?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E3426C989561D842A8896CF134DEEBDC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3b5069-8fca-47f6-4d34-08d988ee87b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2021 17:27:10.9095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qjfc9+D4d3cjo4Ez4XVtR5bq1PEu3Z7EgkjXWbxQwckUvLXO3vzP/SmuXGdB+NASlqWAd7oa+e8PzIAydZWzLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10129 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110060109
X-Proofpoint-GUID: fXLzHICWbxaRzWkFCMTkovA-eCyX0P7m
X-Proofpoint-ORIG-GUID: fXLzHICWbxaRzWkFCMTkovA-eCyX0P7m
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 6, 2021, at 1:20 PM, Benjamin Coddington <bcodding@redhat.com> wro=
te:
>=20
> Why V2: further testing to verify INET6 handling, fix spelling mistakes
>=20
> 8<-----------------------------------------------------------------------=
-
>=20
> If nfsd has existing listening sockets without any processes, then an err=
or
> returned from svc_create_xprt() for an additional transport will remove
> those existing listeners.  We're seeing this in practice when userspace
> attempts to create rpcrdma transports without having the rpcrdma modules
> present before creating nfsd kernel processes.  Fix this by checking for
> existing sockets before calling nfsd_destroy().
>=20
> Signed-off-by: Benjamin Coddington <bcodding@redhat.com>

Thanks, applied to the for-next topic branch at

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfsctl.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index c2c3d9077dc5..696a217255fc 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -793,7 +793,10 @@ static ssize_t __write_ports_addxprt(char *buf, stru=
ct net *net, const struct cr
> 		svc_xprt_put(xprt);
> 	}
> out_err:
> -	nfsd_destroy(net);
> +	if (!list_empty(&nn->nfsd_serv->sv_permsocks))
> +		nn->nfsd_serv->sv_nrthreads--;
> +	 else
> +		nfsd_destroy(net);
> 	return err;
> }
>=20
> --=20
> 2.30.2
>=20

--
Chuck Lever



