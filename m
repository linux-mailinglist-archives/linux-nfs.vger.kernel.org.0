Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA4932459B
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Feb 2021 22:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbhBXVJW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Feb 2021 16:09:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:34918 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbhBXVJU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Feb 2021 16:09:20 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OL6jOp045093;
        Wed, 24 Feb 2021 21:08:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=EbgWWKBA77AcjLagPDu2S81PF7mzbMVICOrp/s4FW5E=;
 b=cpTdEO7iIve0t1j3FcRZx0JPFFOyT8F/P4wjmg12qnCd5pPW/AfmEBJhve/paUBmchat
 f1iIDBfySJ2LrIDkfX4moqpmVL4Ml5bSXBPhr1WdDixZ3CdJZmGefdJW0uBM3QQdYH2k
 oYP2Sny5zknyrNYtvAjAcf/9AWOwVtI6x5Rf3c9q3dqtWEwmSO1MkG7wqI8QlpK8G5r3
 Iysno7nL9RoosjkMIyNNeIChWI7T0PWvp8nWfgEqbD2AzaCQZXR0a+c5+pYHO8Wjjjq+
 nFUbDiDZnK+VHA4Y8EdyKgm6Ra34GurZxB2CIj93QO3kwpFzG5uL8vvtQ70i2dc3ICIX RQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 36tsur4eae-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 21:08:29 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 11OL6AlC176271;
        Wed, 24 Feb 2021 21:08:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2051.outbound.protection.outlook.com [104.47.36.51])
        by userp3020.oracle.com with ESMTP id 36uc6tmykf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Feb 2021 21:08:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWgLU2UW7PxttwIcRW9ipCWL7Z1AiKaPdDht4CLFz8sV7Fls6OPSCYEHmt9ncOF29J98h40vq67oXI3W8Dk6E6A1eTj07Q2Ngpxsq9BiwyJuya3jZHAmRT9iYZL3Y4vBd1Bol3L/3qGjAE0FbEWA0RwlOfh/Gtg4U7jEbKAZXFIk1S6nDpZDdR8drVZhDMlvHDTfReaPmF3Y2CyKwEvtZ5yVOPWfu6gSt+vbkj8x6/bbXVDrt6SYP0nxwEzrvp6OTmdZmBTne4wE51mSevqsiLPCVJByBRRdRrTWEW/HJo4pmr5T3ng9+rKI2HuMAmrUJ9Afoq3/2Hs3hW9L9mnoJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbgWWKBA77AcjLagPDu2S81PF7mzbMVICOrp/s4FW5E=;
 b=aExHaqM+dIWzauAVoOFRFlD9TueyPXZB6q7DwwBdRWO6OL/CdfBT+9+bxfDIw3QoCDzWfnBoKXV40ryb5LRzr3yfdSoZK7hgGpgO+vWVu5S4hrM0DiPgkiYjMFaEYO3xDI13RQ7H2ensqvyNVcRTcemm7ybE6ICWk9PBkyQHd6uVm1q2JkxG/OTrfXAmY5h8wsaiUNfF3WlcfKeHqbeO1IU3cekIwn7/O9KUSgcB8zCaN4kNu+qPdJaV0jWUD9s13JwkLczrvTJ4n+whJEnK8UbNHU9Ula201pE4FwMK93PxX1pfxNPJ7hF6+9XyLuLFD9AWDUnic0fQldwfHCUKSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbgWWKBA77AcjLagPDu2S81PF7mzbMVICOrp/s4FW5E=;
 b=Tc2ka9wior91mZdCQicjzOq3+bbAT2ieCsbPcSHXEcAdpmfRTIEu3ahNjhTpZiYghnKp4zu4C3chCZ7jRO9v2aylj71lv4wHryA++66Loq1GuHcu7EP2vDeAf0RTgNQ6uOkoSJM/4rUUO9VvZ3HsAymqWm6A+OgLQEg6+mBL/5I=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2872.namprd10.prod.outlook.com (2603:10b6:a03:89::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 21:08:27 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3890.019; Wed, 24 Feb 2021
 21:08:27 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Julian Braha <julianbraha@gmail.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: fix kconfig dependency warning for NFSD_V4
Thread-Topic: [PATCH] nfsd: fix kconfig dependency warning for NFSD_V4
Thread-Index: AQHXCvExg0cHIUazCEiSB9E8F7y8OA==
Date:   Wed, 24 Feb 2021 21:08:27 +0000
Message-ID: <989596C7-645F-4D4E-92D6-62547961A9FE@oracle.com>
References: <4276512.Scm06nC1gK@ubuntu-mate-laptop>
In-Reply-To: <4276512.Scm06nC1gK@ubuntu-mate-laptop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38921855-dc6f-4445-fa18-08d8d9085461
x-ms-traffictypediagnostic: BYAPR10MB2872:
x-microsoft-antispam-prvs: <BYAPR10MB2872A01C06CC5A3D15573696939F9@BYAPR10MB2872.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rKy4WNKO1DlcRpkvFcKfPI9eu329eiY6t+ffMy84E0ZPZZBpd2rbARgSDLBXme5qEYkYwwVSnaGptXHM97GsTd5ozuVykJ1qopMq+sq6JaSS4PJV3aOeEt8wntVPGvXj6JFDdHc/HxDMCaYVDy4wnj/RWK9QQ280kslz8pV1OTVEAqtWr1Kz8cZkmmAFc5e75RrYO2wMytUfqAaKFBvdtU59d9X7B0ulUgvoIvJmMCXVjS+n0Zl3yZmrPWiri4mlpaSU3l4rcQRCz8bxTj9suTLAmSn227RzIIJR9h3T6Dk8wyQG45l6PwMw4GNO3n5QUZuxZPDqVUIYQYa3cmx9oqYQx/1qDRNja9sCEFMY5jORvrOft/+Cgsewn/GvCDDnCpgGvBFTh5YVQZS43Im4vBiQRHRwqLopPMXWe8Oo9nqVTFrl4kNKHiobWSuccwn6FzYHf4akdUGXUwQpVph1NjLjtkYa7Kma2WtVQclQPF87Qk+PeJzhhEOV7pE2Q7DYyldh2znz+YZ3zwI2oLCD/CzErQKqBsB+YcFI0KE0gdeUIs0BAgKGgwTllP/8yZeT7+WSGwIsVdRhuuFUi3Dr6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(39860400002)(346002)(376002)(366004)(66946007)(66556008)(64756008)(66446008)(66476007)(86362001)(6486002)(76116006)(26005)(8676002)(186003)(71200400001)(4326008)(91956017)(6506007)(8936002)(53546011)(33656002)(6916009)(5660300002)(83380400001)(6512007)(54906003)(478600001)(2906002)(36756003)(316002)(44832011)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?cPkK/cVIyrLSkmMFXf9gTIgVbLQngXFGFo3uhu0NUZDmFO+YCydhGAqd2XQ9?=
 =?us-ascii?Q?j354tmKXDDwGRHohL+QI9cR75xJJ5OvhQdvoampr5uJL+KbvyWfsRXjq4Y87?=
 =?us-ascii?Q?V4r6wo0a3N5IQAudIWSOCB1QfvxNqtsV5T4LxRed+0M0MY16VkE8gUpNVwiT?=
 =?us-ascii?Q?XM6nov2PWoOKQ3i19bSfpBwSzXPM++LUezY1KnLPokYtx4RZJpPGDwiYRgof?=
 =?us-ascii?Q?mixQjTuf4yxWUi+CHJQlZbYc8+OK2OEOOP8Db38wK138TryssGGaCNS2+lzx?=
 =?us-ascii?Q?UwcAJ4rS5DB7atldI4uq4loRaNsU0yCqhkMUblstG5nMEBksr1jblSpXImLG?=
 =?us-ascii?Q?8f7IKA1EfCk7680S1YBijEctIxSPItW91Hb2SbUubRGDB5Fo0zXgyVNtUTPF?=
 =?us-ascii?Q?baXYlwc/Vtp32NbAaowqIebhTvoBpKM+O5qtMnwte5UWMiv6JoG+BcOJ4KPb?=
 =?us-ascii?Q?1HDUhTxNqfg2iQUFxp1SVteSfu3iOcD+++kGPM72cWzkqaSxSRv89O0OCAH9?=
 =?us-ascii?Q?AMCHDLh8h5lw0ZAXUAkgrILmwLw7DbwCDlTY0q1dJ/UJjUXeNa81/14+gtF5?=
 =?us-ascii?Q?F8EcDbvMoWkjL6CMBV18bfUg2/tZggVL0ss6Q4r/h3Bq/5cEsCaYYJxfLVWI?=
 =?us-ascii?Q?ZiYqI8qBBwT4X6TUo+5A2JHdzzj70NP4WDt+BNzABfCCH9a4eTn7JfKwfERs?=
 =?us-ascii?Q?rTIejuLPWxeX7tMTqF+G5fpeQWX5XqTCCSOOro36qcXiS+S+4AB9gK66lOIo?=
 =?us-ascii?Q?W+TIPEOME1fzlDfuQJN3F488izmnFEmLns17UOsbaPjiCp8Aj78UO4PqB3Fx?=
 =?us-ascii?Q?Od71pgEgBYfhmWbJOR7ndvW5TLa8ylFu9H4f6lJQcwC/buKyF0RauZWQJv61?=
 =?us-ascii?Q?49XtG47bp0XqkfIpLMMyZIK5Qk5Malo8ZA9MMJH33fqp5a7z4PzaBm7aknbV?=
 =?us-ascii?Q?CQxb315XREWf4v3rB08U506RkHhG+jP6x9hdSJPAr7l3Scs+9/0kt0rVQAQ1?=
 =?us-ascii?Q?BS1mVkOIHfE0koU7Zvx+q1/SaPCSIDQIBAI5a+32rh44fvdu3jSpQhk9errj?=
 =?us-ascii?Q?NrCtt+x5/RIdDmFwFNFNUsSxWwInEGi19Y6IxMXnkQ5kSy3RvYMJ/OVhr/Sd?=
 =?us-ascii?Q?n7rbE00TEg+3YFYtCCuwWgHrGlSYNPqXXKQISBPelYwGS8TBq0a/gMmkya/m?=
 =?us-ascii?Q?YjtkimLeGMcCSffkoXyAkViJPsCIoddlAnC0ijyuVdwGJNG0EQQKL8Akl4eC?=
 =?us-ascii?Q?OdhqG0s8xqC0d9+Ez0BZXbxwgNPKmLnF+ENIpCdJFOBycPSQQNt53FF4l08Z?=
 =?us-ascii?Q?WGMWm57JSG8k3CF/iWhbITT9SWJLXeV+2M+u98CimbqJFg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5BB1BDC5172B1C40AE8C7F1BADA49859@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38921855-dc6f-4445-fa18-08d8d9085461
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 21:08:27.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NhBM8BXwZ9YNpXSiHRdpPU2ZduIbRnFT1tDGEFWDk5A4QZkyG8XrSqkrrl2ESr91Ie91u88kEPlpF0gZ9oDQhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2872
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240164
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9905 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 clxscore=1011 phishscore=0 mlxlogscore=999 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102240164
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Julian-

> On Feb 19, 2021, at 4:56 PM, Julian Braha <julianbraha@gmail.com> wrote:
>=20
> When NFSD_V4 is enabled and CRYPTO is disabled,
> Kbuild gives the following warning:
>=20
> WARNING: unmet direct dependencies detected for CRYPTO_SHA256
>  Depends on [n]: CRYPTO [=3Dn]
>  Selected by [y]:
>  - NFSD_V4 [=3Dy] && NETWORK_FILESYSTEMS [=3Dy] && NFSD [=3Dy] && PROC_FS=
 [=3Dy]
>=20
> WARNING: unmet direct dependencies detected for CRYPTO_MD5
>  Depends on [n]: CRYPTO [=3Dn]
>  Selected by [y]:
>  - NFSD_V4 [=3Dy] && NETWORK_FILESYSTEMS [=3Dy] && NFSD [=3Dy] && PROC_FS=
 [=3Dy]
>=20
> This is because NFSD_V4 selects CRYPTO_MD5 and CRYPTO_SHA256,
> without depending on or selecting CRYPTO, despite those config options
> being subordinate to CRYPTO.
>=20
> Signed-off-by: Julian Braha <julianbraha@gmail.com>

I've included this patch in the for-rc topic branch at:

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

However, there was some harumphing over on linux-rdma about
a similar change for CRYPTO_CRC32 and the rxe driver. I'm
not quite clear about the outcome of that conversation. It
seems like we are going with either

 - add "select CRYPTO"

or

 - add "depends on CRYPTO"


> --- a/fs/nfsd/Kconfig 2021-02-09 22:05:29.462030761 -0500
> +++ b/fs/nfsd/Kconfig 2021-02-11 12:00:48.974076992 -0500
> @@ -73,6 +73,7 @@
>   select NFSD_V3
>   select FS_POSIX_ACL
>   select SUNRPC_GSS
> + select CRYPTO
>   select CRYPTO_MD5
>   select CRYPTO_SHA256
>   select GRACE_PERIOD
>=20
>=20

--
Chuck Lever



