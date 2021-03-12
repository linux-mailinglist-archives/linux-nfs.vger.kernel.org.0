Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04893397CF
	for <lists+linux-nfs@lfdr.de>; Fri, 12 Mar 2021 20:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234476AbhCLTyE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 12 Mar 2021 14:54:04 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:60312 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbhCLTxn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 12 Mar 2021 14:53:43 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CJnX7j145774;
        Fri, 12 Mar 2021 19:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=yT+osfhiFXS/aaJ5ytaHBDUJ7QBQZhxzGedQ8ol3q3s=;
 b=tb3wrwmOxmMhXHQgYGwmoBDjhgsyE5fYG+rPvIu49i77i9N6h2r/chgafZKuDjNYoblR
 6bbXChycce/uMdumrVSibZ1pNwVvhCZg7Tuz8YAKdGmaABba7b0PWwhyuhrTelkGgPi5
 m7ofe9SpuWGhRzIH4bmwUC57HhIVuXpFUvRsZ1nTAqb9jYTBGqVkkI6xPnWUexxI4FtJ
 h6m6AH0qWSP2f0u0w4uVM7w+L4edDszTTklliW3axQHLiyqZmCt2n6OjtDoGT2BZ8TrM
 8N/RdmJfBLaAjmJjDzm8y+loK3ac8+CnpIWGAB2JrO+OTavdcZyDSH99N/LqXxvSi4Zz jQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 3742cnjxrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 19:53:24 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12CJpQLR184259;
        Fri, 12 Mar 2021 19:53:24 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2042.outbound.protection.outlook.com [104.47.56.42])
        by userp3020.oracle.com with ESMTP id 378cexfmax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Mar 2021 19:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OApeXo+AR0uh1IgI7+dsCY+dkI9AVBu9VzowA/XlX1TVfjSPLeO/X7yljU+zYf1WfF3wVTfUMx2OrEl1xf/6oOGWj9C6jtAKJjZjg9sVQuhVNKKHTMjqHJdJNlRVfwkAlvy6TFC4YxcCiEZXb3EPBFrdC5Qm517g11K3HbZZ8wD2lfJFMEjYDifmhy10920T5GheBF7OnXvwd7i1nx5p5X+K5GzNX37x16XQGwPmYUvVXG/RU21fGgLF8CTaIfkBOn51qXJkfN8RQuVhbwmfvkUbjJPHAamdHBQFF2872j8//xnJpY/oqC/TM7Ep+WWNzXTxf3TehgHZmFrEtsOmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT+osfhiFXS/aaJ5ytaHBDUJ7QBQZhxzGedQ8ol3q3s=;
 b=hHp9eGToSmHRwER4OsLqboAs0Sya34u6vaj9sZzvOUGRTJGJ++FY1l2jLn8lhMuBR7Iw6iTUkh1OGNkMA3P3y+X0vBgFK8s3Z/uT8mfh9iONja9oY4nXlUmdmHjteyymPgSPzTW3kyueQgXmzJ9cQEwQlj/yBnxBI6Y2/FsCAjdGEzTNpQ50K2xlNQNmqhEFk3EjbrEF6VxD3RbI3SKkTXm/rDljVQhj0LGIAGlhgK2efHJIsNpNI/KYPewJapzkY3BND02DCJJj/N5fbsRfW+WEJ5hMpda1YdSGJ8RyklGG1t4fAuy/9RfDe1uxaXIK8Bvn1CRR5hOOqO2RtQzPjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yT+osfhiFXS/aaJ5ytaHBDUJ7QBQZhxzGedQ8ol3q3s=;
 b=M76jn4A6TnGcbQ52NlL9Gauyeahd8drSJmqh7KiTOmLETQn1UJTcKKLV9lczsDcD7Pk8fhHJDB0jmYScEop0ZcpLCRUcHZwDhXTBOe//NlKN9Tl004PS/Yw2Cl41q+kDAgSI1vuEnSi9IhFP5eO44Ae67/BUjCyQ33ZsR3lsNSY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3045.namprd10.prod.outlook.com (2603:10b6:a03:86::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 18:59:24 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3933.032; Fri, 12 Mar 2021
 18:59:24 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v3] nfsd: Log error on UMH upcall init failure and debug
 message on success
Thread-Topic: [PATCH v3] nfsd: Log error on UMH upcall init failure and debug
 message on success
Thread-Index: AQHXF2K+y8nL9p7cMUSkigZChQyYHaqAtNuA
Date:   Fri, 12 Mar 2021 18:59:24 +0000
Message-ID: <D3838AAC-6AE6-40C8-B13C-AB19796BE36E@oracle.com>
References: <20210312170604.56169-1-pmenzel@molgen.mpg.de>
 <20210312170943.57461-1-pmenzel@molgen.mpg.de>
In-Reply-To: <20210312170943.57461-1-pmenzel@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: molgen.mpg.de; dkim=none (message not signed)
 header.d=none;molgen.mpg.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9f5ac544-5181-4bd9-af54-08d8e588f3fb
x-ms-traffictypediagnostic: BYAPR10MB3045:
x-microsoft-antispam-prvs: <BYAPR10MB3045F89B4043BC6D79D4FC81936F9@BYAPR10MB3045.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sAnRZktzGKIgbr3lVhYqOkT1wphRhC9jBVqHN4jcrFb0fVxBxQI3Q9i752Ehpw2oD8sqyEM/NEn91rvnik11R/SzGnzv6Z11YaiIT9fO7QQTNBMHug6oFz8MIDlWZFw2MAahVW8lBPtP+GSzootiwA5GgfLSvG/Wgf5Ut4LHd+SEWr6P+4Hk87pzeqyLZFYwCAKkGOLWSkb194ePTcZUCRqfxMvIGjjWXnVP4GUBMSJZP5jUg81bqfoYlfySR15kfVY1VwwtHQ+CjtBtpHDgKw9yMJ2Ww3KzmFU28IiBzalQ9osk/T6w8IheHXGR0Ye0frsY4CD1y1JN+TdeEIF0r0QHDkc/Ewq4nQlIqyzwJhmj5SnLAzt+bdsUYZXoU+L/sBDi1b840SaO4RuVQYrOQw933r7DPVKg/j1YhIow6ZF+ZctcKzSYg4z1hPGK8NwfS7gX6mtbyk0DXVhVh9ZIsh9CnQWFrpY6qXJJNNiCa2SK6as5kNkUj6+eRIaJnmlswaDu1tFdTTYqc4OzVTBrOG73jqEjJOu82f31jZ6xeZqg7iwotERvX7z2BiAj34Y0j7aq0D4nJOuSU9QB/kyd8Z+zbJB7VQSp/thQJjQH6ZEnIK9lkQxI/b/qvXLNjPsC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(376002)(366004)(346002)(136003)(6486002)(316002)(8676002)(54906003)(15650500001)(5660300002)(66556008)(91956017)(6512007)(86362001)(53546011)(6506007)(4326008)(6916009)(8936002)(478600001)(64756008)(2906002)(83380400001)(36756003)(66446008)(2616005)(66946007)(76116006)(71200400001)(26005)(33656002)(186003)(66476007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?C9G0ox6QgJqrd6ekOHq6OJIdxfdEJTBBKOAKwACJ3vVQYIg1T5eDYBWy97Cx?=
 =?us-ascii?Q?ElATEFq5F271xf1hEGZTnvNJ1Ay0KORWV/WgJmttj7XaSOyi+qgVnAUn/aLX?=
 =?us-ascii?Q?t+ByzJSjxNgHWN+YK5pC+/vq32qPFZ1IMpzjqsHL/cbVBWT1w+Lx1C+hVnSM?=
 =?us-ascii?Q?nLDpg2EQHDgS74emcLeSbbFptg6aElGncscueCt9+R4gAHB/PIprFjOaxf+4?=
 =?us-ascii?Q?SY3/ApCVFobAr+JqTFcHyZjEhdfvKEU10Q82yZ5FJu1pvKdprW9egCbQV0j3?=
 =?us-ascii?Q?9KCdwGiFZKbpeqIc1Rt+YmUgsZwcXcPen0yZPa+BFphkBvTeExfE9JfeRTBD?=
 =?us-ascii?Q?Q3vNRKSqWf+WLKCpaM2qObOKsJi/s/NtDcLEbSblvp+9kBbvdzZj3RhW04a5?=
 =?us-ascii?Q?/ike+Jjidb7Cqs0z/DIeC+F9gb81EtJYABRkM+NMCKix1AucWUHB4Gx5ptzS?=
 =?us-ascii?Q?J7faNBauPxo15AfpgrliaVEvs7hQOFuev6UfslrOBVNXbTMnJj42J76qJcpC?=
 =?us-ascii?Q?wbXKVLpMHKAp43N9lddtLPa0TQuePoSwUGZC4RvjGB0He3jAT4VvN3hwss1s?=
 =?us-ascii?Q?MHJ1CYgHuHi8DMl/5/Os6HCbSVOSVGyZtjwGOzJSMFpwO/gLYXaGSIew3gFr?=
 =?us-ascii?Q?zgw8DeDT/meGdmRYuMrj93gfFPLM5D+ZhPf/46BSMRPKeQlsC1+GW9zMl9NA?=
 =?us-ascii?Q?+8HqTtjCIZfpv0jxrNK6Cv92xD8ndZMH2pSZE75OeINE0l1fE1B+SBDEmkow?=
 =?us-ascii?Q?jNvP48n3kJLBP+k0gfyBqSC3e9sjRwm8CLjyTc9Dt1YNAd5l41urjKLPBc7j?=
 =?us-ascii?Q?KwSQw1nnstSAUPdft+CPx0f4ZvewzVcKrI/cS187Stmt01QXp4XBnAXE0ymg?=
 =?us-ascii?Q?4irXFP2LsEPKmcgVE6Ytaw5U1VU9XULvn0aSPXwhb78osHQ0tw//f+tU7Mmk?=
 =?us-ascii?Q?oaEHEfM5sFY1u3PneAkyYkNipLWtO8qgupvlJlMaoONr4gJbISqQhK4XtktB?=
 =?us-ascii?Q?FGUG5ubehq6tqgR2p5K4zd+pU3doxbGAiqbC1Z7NnxEfEe7F5haIGu3MfWD9?=
 =?us-ascii?Q?Pv5DyJDShfllYl8CXF00DVhMF5xhq788kfZvHEoHFubqh0lICiw87Ppldy50?=
 =?us-ascii?Q?s8IUdXP/ZVOqOlKZgkAcRW+8R+d/89l5L6TF12EDlfY4RG85At0MKeq0R5iu?=
 =?us-ascii?Q?wiTaGy/I+zygX6tA2vYWtEoTnZyaTp167Qf0eg+WVCg7B1ASPIEigooaxqrm?=
 =?us-ascii?Q?SlBHIJcgIHTZRCwXOybX+T7/aMttZ4wvSFN2B6Xk76hc9S66Q+GzEwBrRELT?=
 =?us-ascii?Q?Y2qhVduHDVFj8Qj0mdeI6VsD?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <FAF435C2124B284C95E3B15A7FA8505D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5ac544-5181-4bd9-af54-08d8e588f3fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2021 18:59:24.3938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yIDcGMkCZTAA1CI99Isj4imc8omrTFkatmYCu4GlcfzrXV3wTvDpd1BtiorbKI0KqNae3AlChITE5DEG46evkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3045
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120144
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9921 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1011 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103120144
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Paul-

> On Mar 12, 2021, at 12:09 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>=20
> By default, using `printk()`, Linux logs messages with level warning,
> which leaves the user reading
>=20
>    NFSD: Using UMH upcall client tracking operations.
>=20
> wondering what to do about it. Reading `nfsd4_umh_cltrack_init()`, the
> message is actually logged on success, so nothing needs to be done, and
> it was decided to use the debug level.
>=20
> Additionally, Linux now logs an error on init failure.
>=20
>    NFSD: Failed to init UMH upcall client tracking operations.
>=20
> Cc: linux-nfs@vger.kernel.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
> ---
> v2: Log error and demote success message to debug-level (forgot `-a` in `=
git commit --amend`)
> v3: Actually sent correct diff
>=20
> fs/nfsd/nfs4recover.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
> index 891395c6c7d3..fff89c739033 100644
> --- a/fs/nfsd/nfs4recover.c
> +++ b/fs/nfsd/nfs4recover.c
> @@ -1863,8 +1863,11 @@ nfsd4_umh_cltrack_init(struct net *net)
>=20
> 	ret =3D nfsd4_umh_cltrack_upcall("init", NULL, grace_start, NULL);
> 	kfree(grace_start);
> -	if (!ret)
> -		printk("NFSD: Using UMH upcall client tracking operations.\n");
> +	if (ret)
> +		pr_debug("NFSD: Using UMH upcall client tracking operations.\n");

Looking back at 869216075b63 ("nfsd: re-order client tracking method select=
ion"),
the idea here seems to be that only one of the "Using yada upcall client" i=
s
supposed to fire. If an error occurs here, there is a fallback. No addition=
al
error need be reported, IMHO.

So the printk() call-sites added by 869216075b63 all need to be adjusted to=
 use
pr_info(), I think?


> +	else
> +		pr_err("NFSD: Failed to init UMH upcall client tracking operations.");
> +
> 	return ret;
> }
>=20
> --=20
> 2.30.2
>=20

--
Chuck Lever



