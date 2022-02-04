Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FC2A4AA190
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Feb 2022 22:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239876AbiBDVG7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Feb 2022 16:06:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:42544 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239702AbiBDVG6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Feb 2022 16:06:58 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 214KxIoB030949;
        Fri, 4 Feb 2022 21:06:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=s6HXQIiJpQMjkNIPPPp2p0etZ4rSucUJ2G17EY4O62E=;
 b=Jj/Y1X2YlZ/+nbSbhPcpCgE8g1ghyEXqNA+RGGk/JZhOKy+4biyWquwlzoCcpVh+br3A
 uwv8CG8ZBZ3XXTC24x8HeYyyZIZHuMv6jYKccohh6DKP286zhVG2Jr6udSQCJTnDw8Rq
 yiQHYYNll+/lRPIXTfEQpOgYXyFmt2v9K7YG65+T1X95jQfQtRvpyXqKiQb0ckwTnX3+
 20eeyOFSpDOF/yvOSr77BymOGjiTpB/rrY6aLvAfnjL2z9EgxaPbcZ+UmKOejiKnrFmE
 YGWUXPVSV0Z+9qC3FCphBX+sWd5f5t/yQiKzOpgKF/rIkYkNZBCUZIbxQGKc/TnGAymU 7Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e0hetbv4g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 21:06:54 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 214L5q0S186592;
        Fri, 4 Feb 2022 21:06:54 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3030.oracle.com with ESMTP id 3dvump3rbb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 04 Feb 2022 21:06:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLajVbiqDYgnIjqZ37/xlI3rty3QL1czRm9vgwRfaSOsC72ZAoc38GXIUs1QH2gQJhfiMozlGNfcQo/aLVEW5z1aQloQCoZnZ4EV+BeuEX1f2u9FIKKLj2Qvo092KC6OyN2QAvsxrdZiryMVtHGNf4B1hu0RD6h5bQfe9ypyIIUc4dkWZWojGcMQoBddfeNeJsb84d3RSQwTPsuCrWmzR/fUDM3rxxf5DY2VMyc+TraDDOhSq56LMu2u+bhB+cydKU6t+OFCHTtoF1irTOUN6qKxwRTmW9nfX0ezu98Y7AZzpFhDgsB65OBDBNLkMTVB6mGNtTn4/sZjPFLmwER7og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6HXQIiJpQMjkNIPPPp2p0etZ4rSucUJ2G17EY4O62E=;
 b=lzoIPYfQo/J6gOhUzPgcMt83ZzzknQmIhI4jt7ZjrgTqpPzYccSBHFUrzcppQCIt2/6EUplPdxCDG5iHO06btjQX34WZSgDyAoa6HW/AluL+x3r69sfomDAl6uyrAue3zDI+z12P5SzSXgMpYoWkOheABkKQog7NStNZqNemdpvnrv+ufuolFooeEMBl7N2ZPPe9JfQaj59yUYIGomAmfOna9ls8OMjsaL52dohpxk+XSXE+4ThqLz57yDH8Uw4Kyciv/n/cjFVcZZXmlJSBMND8QG2a5M3I71LEyE3R7TvpiGrs5Mp+VaNIQuybWU7b5CMYqEDFJ9SOp2VszrSw6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6HXQIiJpQMjkNIPPPp2p0etZ4rSucUJ2G17EY4O62E=;
 b=EbC2NLOf6oYhkM0kMIu7IYEgb1RbVY9jC1f5/anoXk5xDtz6HQhOrXs5WhCJ1iFxJeo2YKvuevioNnut8gaBqowHXxNq79AFVuabMmJ10ziGH6OSUY5Ml8SxWbwuJIRZ3/uIGuv7PCaqDj7Wdf0cvApBSr6OLBbCZzbqSpvYaJk=
Received: from DS7PR10MB4864.namprd10.prod.outlook.com (2603:10b6:5:3a2::5) by
 DM6PR10MB3643.namprd10.prod.outlook.com (2603:10b6:5:157::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.12; Fri, 4 Feb 2022 21:06:52 +0000
Received: from DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00]) by DS7PR10MB4864.namprd10.prod.outlook.com
 ([fe80::6438:8348:3b0a:5b00%5]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 21:06:52 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Frank Filz <ffilzlnx@mindspring.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH] Permit COMMIT operations to return NFS4_OK
Thread-Topic: [PATCH] Permit COMMIT operations to return NFS4_OK
Thread-Index: AQHYGf9a16rkY43bwUm9r8nBxvfdVqyD4PYAgAABTYA=
Date:   Fri, 4 Feb 2022 21:06:52 +0000
Message-ID: <EFFC7DB4-7D3B-45BA-A3E8-F34271F8FBBF@oracle.com>
References: <164400374422.1026143.17746475126462213720.stgit@morisot.1015granger.net>
 <0ec101d81a0a$7bdfa880$739ef980$@mindspring.com>
In-Reply-To: <0ec101d81a0a$7bdfa880$739ef980$@mindspring.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c61f6e4e-10d0-47b0-3a5b-08d9e8224454
x-ms-traffictypediagnostic: DM6PR10MB3643:EE_
x-microsoft-antispam-prvs: <DM6PR10MB36435BBC2A8891C3859E739293299@DM6PR10MB3643.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A8knnYQ0gmMs3zy1hiRNFo8+wJFsIt43sK6mIHFfAUCUIUUI2FGWCpYJ1eHdTXQmttstX2zX14fDpEPxLPNuVAs4VkiDZH4ycrZe8exTD1JMB0oRmyeebm05Xq/3R0aw7a7Rv6ZWSYuXhZjGXWnjyufwmD9mNlP2P4jfEH9KuGU2MzDOZR6PsZjxVTV47i4CLnx9+plq9xXhjvLQrvSwY5G6IKVTx4hxRpmskyIVNMB9v5Ut/EjEuKVfq8v9TSG/WUo2UDCreNSCbxCRVKLNfgQ7IpyOIXQR49nzfgJDXGkBzxOEuWVxRG3a7xfQ1qwkdkonI7BUHKlxhsQf8a+Jt/x/mZm0MGGmUZCAKSlYHj29cVT5ekuntwXFkB2XDX3SL5T6fsdQNoY5Pkf38XTz55zZPXcG4bGh/Z49QMyzmophbseNGmi1+TN0nsj4JeejUwpVdbRmWChtWHOJjm8+H4C4cOOaJVorSCT0vD2KKf6luD0XKMaPMbgOajLaE9kyQ6peI2iYQsHX24dwEJu4qLq2xj7iO+IE/HDtWJ5/M49T1NoJEgGkv0yh0zyFFdm7r423xLz306I2dxLdDo7JUaueMllwleXj8DH0kLvsvygdmfDZCskKmrNQBgaX3T+JdJyNlkn8cP92RQLHeo0+Pb71qqpcmmkI1MV3W/2p984ETo8oBPgVmC7FPH+P87A9sGWfdrXrUhGNE4W+/fTfXnOBQxKs4xx3IsIYSPaiy0Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB4864.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(64756008)(66476007)(66556008)(76116006)(8676002)(53546011)(91956017)(54906003)(5660300002)(66946007)(36756003)(6506007)(33656002)(4326008)(6512007)(26005)(316002)(8936002)(66446008)(2906002)(71200400001)(186003)(2616005)(86362001)(38100700002)(6486002)(38070700005)(83380400001)(122000001)(508600001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/meruFTJlB/4x+a2/9o44jZnyLcakuh6f7JzGzO+YYxlM13v2mJVOstOW5ic?=
 =?us-ascii?Q?O96oyzCeuv6IywVmxCl665ZOtlHxtnUO92QBm/r06CvR4X/SY51wn0CGsPsx?=
 =?us-ascii?Q?V+XGIrRMwhu2Wwnmaabpf2mXKW1vnUZmd3GuCNQoc+qZ9aXwLMP7j30Dt+cr?=
 =?us-ascii?Q?nmW7b1d76jJi/PTp+9mUFYbtukZxi1yFKf2egrz85q0Xdgb6MaSOj1t1sq4V?=
 =?us-ascii?Q?lBoHBtpedyuraJO0Sr7zeWQpEUaOk6SdN7EotIFobqngbf0Pf33D/vU5Lccj?=
 =?us-ascii?Q?I/6WcwZFNreUUub6VCR3DFEXPo3CLf33My618IyTj+eXlV1bCo2pcJuye4aK?=
 =?us-ascii?Q?KaFUlhVZWzyrUMxykZiQpT9HOYF3/UFkIQNpvDvUKbP9q+GaImglKzi7GdTX?=
 =?us-ascii?Q?RYkRKnNthE9F44IRsuZhkWeBFrQTn3LIwVliydDK43Qdb+zkAt052dBN+0lJ?=
 =?us-ascii?Q?fnUEgolmFI/KGfGfq/tFMS99xEK+4uJgrtmCDzKg7pWnuU2sMVcRodTYgsh5?=
 =?us-ascii?Q?VlXswUNaUkQUhT/E6V72q/vxMs+pBSWq+5Cnip6un5LslXnWdioRlciEjtTi?=
 =?us-ascii?Q?48owD1dPIPRTw0tE3W+O1eAG/dH/6v73Oj1DrW8cib7q6GLX1XWHA+P0Fnie?=
 =?us-ascii?Q?tVC0UTE9rC89cn8FcFAIPcmAmX67qknpK56EVd0nX8Qerhu/YatPOiq78sJv?=
 =?us-ascii?Q?pABEvOlwq1dW2KTrigcbDS/P1ZAidH5y8Bt9G/bKWzd4O5Og9pUM8yDaKpzW?=
 =?us-ascii?Q?1GMvdMjr/I8cgae+LimKWPfn8hoHmr2ZR5SL+ssQxbQTJZLc2cqD5VJu7fsT?=
 =?us-ascii?Q?FqdW7mCvHWS8qRN5ELAuqahOTS+cAh+zQIsZulshqpgBCQwj0GTttLAtG+d2?=
 =?us-ascii?Q?ZKpwf+TSFeXniZDITbnYf+cKpFZWvOheiuiIuF3IwpUUsG2LlnnCsa35a79Z?=
 =?us-ascii?Q?6ZS37Ae0G8To2/j3U6fZq9PdhWtRbFq0uQlzkNaENibjKultckreo9rpsK/P?=
 =?us-ascii?Q?Fs06nUKYg5QZtonqfoRGlL82MhCMwcI5Yralh7c09osaDXKNb38XaMbova73?=
 =?us-ascii?Q?lJN8Z1EU5GFPyQt17gks8EBjZygKYDxBX6E3aDh1P5ZiqAuYRaW2eXGDU4qI?=
 =?us-ascii?Q?Nl/u+YgD7Xx1FPx1bfp9aKNXgwYuPdiNraahsTRQbWIC7nVYw3v7+pXBYHAv?=
 =?us-ascii?Q?0z9H4l/059j4Pb+lWdpbZMRz9uq1yoxuNbeUHfTdyN0NqOmFFFIzr8a2q/fG?=
 =?us-ascii?Q?9yeXwRgFAatUCL36xb5jkjE/TQQUcD0tSyWv41+oF10Q3yc68mNjPhuTa+mX?=
 =?us-ascii?Q?CbtP0FONwAYJ7ON68ogMlOWkJDfmJ5kAu5A7gxWl0SL+iPUzcH4H88cxVl1z?=
 =?us-ascii?Q?v/oaOhNN5FMZQZig+bphgjfGZVHbPvvzSpuQ7RzpOhhVcxwuOKQ7T8RaDgb7?=
 =?us-ascii?Q?et9XTOkXcyKFXxovihgT2e5Wi0yBqPLXg5pqGfTtZjkU2tf/W+yrm5K/lOgU?=
 =?us-ascii?Q?bwxLXfDHJMBpY73aBpnYYTOgFuLTvVPBnopKP7ezta/A41Rect4cQkXamMOQ?=
 =?us-ascii?Q?ExFDweIShYLb8TgVzgZGIlNpqYtUPGOJBeWsDW5jD8Co5IXCpomc4qg4Oavm?=
 =?us-ascii?Q?vUSHFYM0EOPDOqDPMvFY8yo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9891DB45C03F754D935C0D9EC8A91182@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB4864.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c61f6e4e-10d0-47b0-3a5b-08d9e8224454
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2022 21:06:52.2069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5dDmQGSS2LNz43VyqCJdp/GpCysCZDlLFqd15/C+nsMl/zXt+Ev+9QUaE6vF+3kT25ZExFrlOl8LI6rK1Tws2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3643
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10248 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202040117
X-Proofpoint-ORIG-GUID: NhZEr97pFmoGFfKrIMUGd19scWcDLVyI
X-Proofpoint-GUID: NhZEr97pFmoGFfKrIMUGd19scWcDLVyI
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 4, 2022, at 4:02 PM, Frank Filz <ffilzlnx@mindspring.com> wrote:
>=20
>> RFC 7530 permits COMMIT to return NFS4ERR_INVAL, but RFC 5661 and later =
do
>> not. Allow INVAL as a legacy behavior, but test for OK also.
>=20
> Do we have a 4.1 test to verify 4.1 and later doesn't return INVAL?

No v4.1-related test that I'm aware of.

Note that RFC 1813 also restricts the use of NFS3ERR_INVAL with COMMIT.
We therefore believe that RFC 7530 mistakenly permits the use of
NFS4ERR_INVAL with COMMIT. Because the specs are not consistent in this
area, we chose to allow either result in CMT4.


> Frank
>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> nfs4.0/servertests/st_commit.py |    2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/nfs4.0/servertests/st_commit.py b/nfs4.0/servertests/st_com=
mit.py
>> index 12a0dffa061f..4ef87e69c5d7 100644
>> --- a/nfs4.0/servertests/st_commit.py
>> +++ b/nfs4.0/servertests/st_commit.py
>> @@ -160,4 +160,4 @@ def testCommitOverflow(t, env):
>>     res =3D c.write_file(fh, _text, 0, stateid, how=3DUNSTABLE4)
>>     check(res, msg=3D"WRITE with how=3DUNSTABLE4")
>>     res =3D c.commit_file(fh, 0xfffffffffffffff0, 64)
>> -    check(res, NFS4ERR_INVAL, "COMMIT with offset + count overflow")
>> +    check(res, [NFS4_OK, NFS4ERR_INVAL], "COMMIT with offset + count
>> + overflow")
>=20
>=20

--
Chuck Lever



