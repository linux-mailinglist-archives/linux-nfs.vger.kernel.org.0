Return-Path: <linux-nfs+bounces-2466-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA3788B4F3
	for <lists+linux-nfs@lfdr.de>; Tue, 26 Mar 2024 00:04:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFB92C412E9
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Mar 2024 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC176482E2;
	Mon, 25 Mar 2024 15:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ynx/iFAF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tCGHoNZ4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B735645000
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 15:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711380421; cv=fail; b=KvzN+KIWc8Zy7Kg9UCa9fYwLHzqig1hAk1r9v/ovNmKsEPg8qY5ZifP+HRrn2m2tY6IKfp2/eyrbNN355NJmBHjYWsbFZsli7SoCiR4oNCRJF/Eto/KvQNoKmm18Z15At6Reij3SORr5/EuP3wL6xAaWgAs16dAvGsseeXPufdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711380421; c=relaxed/simple;
	bh=HImkFyQjLKbEsK1kq4Yc7+HcIhGvao6OmxqlPwB651o=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=f3XFy+yra1BXh0AV9aexp8nbUSvJAoJ2CFNjykXf/hrIu6s6tLCXXQCFvJLPsEpbwufSQSmxzDBZTIVD0tKTK7ZQTk+6C8QC/QxBkx2tgeGuuSE6M49KBlVL1Ve+uSgEPaLZwmhnrPNwPb8jnJx6Tj+MBql6B9krqD43+kkI2+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ynx/iFAF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tCGHoNZ4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42PBuVaB008758
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 15:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : content-id : content-transfer-encoding
 : mime-version; s=corp-2023-11-20;
 bh=HImkFyQjLKbEsK1kq4Yc7+HcIhGvao6OmxqlPwB651o=;
 b=Ynx/iFAF81XDz/Z4amvC3felYYcEOkH0kBR11F3jN2xTSFGcXti51hDAdYMcBKGpUj9o
 tu2KyXfe9IaN6qV213x4Skg7CsOnIth1r7XJzrliPjVhO57PTzTt9PAQmQVi14yIXqua
 3j75RYAf87ewBteKPgZW8+Len7/ljCn2hV6X2arJ45fdz84Ld5/BJrJBc3CleJXFbfVK
 6dMI9rdJjULLzgn63uATBGu5LmYfzSvxHDTTXEHgquX3BH6ISejIaOzEPzjSGwAFGLUx
 PEUJE1CtZ/J/YE+NclKCs7pltieEpY5SFgYMm7peOq/PQXf/filUgDl7Er8RGot+gw7B Kw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x28ct28gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 15:26:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 42PF5HPj010629
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 15:26:58 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x1nh5svnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nfs@vger.kernel.org>; Mon, 25 Mar 2024 15:26:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjNVzfBkOlIVriCZKl7P8zKoPZL+Wp9wE+PqaE4kjnZkos/ehbYNrLOfgdm6RCC9SmQl48Wpde0l8k5P1+J5oFwo082YpdSpTG3xWOdxGLyXS+ORpS5lk7RQKiZLdpojkjZRmTxGl1O3810mff/KfEoLtME3pN35nOnf6eEsg4D8nXtaENHe0QFIYFLFNQSjbcLq7QnBEvU+3IoKrvc4yUltzbsuwum5FPqBBsJbz/eQXj4JDc3n4wcXHuhhiU0JUBP8ibNg2RiXg96jajzq86q80Zrn4lz6gBGaFvDH90luvFVZ1zmHdBVCzzd7UdaBzW5Yl8VzuhsktLAfnTVawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HImkFyQjLKbEsK1kq4Yc7+HcIhGvao6OmxqlPwB651o=;
 b=VzDBtbHKq4lnrQ1LkdTE/+1tRnHJBOHClX2tCsLBqstnrBL6tL9BG6+X0S7iI35iB6FjKa1f6iY6Tb5bROMBLRaQ5ye8q8FzFOnGcW8wMVn2SY5DOJUf7rZ5c91wy4/RrZmzXvIHkqr69HYfa3jGia+8nPIhSYKF4GiKQrSz4tXQE4Kc9NeqGZ3dH+v4i3P0h5AdOQfClqqJj0CVD5lnz570Tvdnu6llNSwSh0HazJoBJn+WRuMcwIapkPAO3TzGJkng7QFqzttEGBZC2kR+SGdSHebZo78+YRVTNeVTOujTomNxXob0cfinc9XnoiRdQ2C8t7Evv5LFUfVz+FBMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HImkFyQjLKbEsK1kq4Yc7+HcIhGvao6OmxqlPwB651o=;
 b=tCGHoNZ4Wm2arLdU/cFyfzDztWlKUDjZGwGLTLh52S483KTh+wP0pkiw7TeSe8iKzh60DB4/hiB/FOtQaaKBiMHv2OGXJSP41E1JX8nDnT4Sc1CzHODp10Lnt5O8Y6v11WingR54pRpE854VE1jr/C3U7GBFBDKekSBhL9qnESg=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BLAPR10MB4945.namprd10.prod.outlook.com (2603:10b6:208:324::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 25 Mar
 2024 15:26:55 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ad12:a809:d789:a25b%4]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 15:26:55 +0000
From: Chuck Lever III <chuck.lever@oracle.com>
To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: long-term stable backports of NFSD patches
Thread-Topic: long-term stable backports of NFSD patches
Thread-Index: AQHafsjeT4IvZQU5jkWS/G+xq+WiBg==
Date: Mon, 25 Mar 2024 15:26:55 +0000
Message-ID: <AF554C7A-F307-47D5-B417-7F311F94BBFB@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|BLAPR10MB4945:EE_
x-ms-office365-filtering-correlation-id: 4f35fe8d-939a-4b61-af03-08dc4ce00141
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TvhIer4BOVJZykKigKEJyDoPtkLYrPqoBSUkWw0VG5yIY22xeGFvROmGYQ9wHjKYJW61lruawQCxxhUe88iix/GI/AEvMtcJ/k/OdD/wzyP5c5bUpuOOOcpOrHgti1iKqHTHNq625yf6w8dYG7RMv5po1GJrLSCosa/h5OWgLUftdsWJdHSBB7NLUZy5LkuiTYfcrT/7CTk6LhDncj1apYhlldHp8gVG0vuz3QHG9rAmFWRLMs7gdoaQ6INnhvH/VfmblQNEMdJaSI+mobDzBDATCJQUuuy5uAVbcBq51vjY97x5KFDHUwYyTnBlfpqMiZV5rKoSQQI8jlg8NI6UFUO1wM+/uz17lMxWyQJMyfGr0JFMn0c39iM2F9QYEffyyeKqs7k0OOB84rK+7wIoYGpZJixdXntf1ijZCD3xl99i0ll6CsAJGhLK+On+5+7Kq9LObzYd13LQOBrAOg4wPVaujoitEKWb6TQvs5aRmwkxmQGVASGhtc0JeHphTZV9cM6rIddmmB+sJ36X3KvCdWPu1lIToXGt4jek9vLEtfOsr96URawHSe+8nyUPPtvtGvpH1yjYMoMwv50WjgxApUnfH3cey+DZj11Wki/qBHmBGeOUJdMvvocQY2kQlpSVuXLNAhhKSHK9ism8gZGyOm2RJbZXhk1IBfSMmoRjjRw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?kwdoimzpYde61bHXDN9nI8CtpUNQaQI5Kg6ZAUGEWanICDaV0RQQIPZG/NAP?=
 =?us-ascii?Q?6aSGjrjVDMrA8KGiKhthcTiIcBTwKzpNcjZ8wB70wjpTM3iisAhv9XdIxhb/?=
 =?us-ascii?Q?sZi/uZT2rG5Xu6XNR8EQ68efEGY1YU7/6HkZrkhWOJUZALhS3ElHJ8GNnpkA?=
 =?us-ascii?Q?I7AMwf5Zof6WzU6PKjoYSBb9EK+mMGkGMnz4j82LjPiN9lpdYEIz6H3QnqjK?=
 =?us-ascii?Q?SO/YOZS4MQVhrecOFTJ9PU01QVkXuwFEhsdrcHunMQEgNzbClHHtSSUer6VI?=
 =?us-ascii?Q?fNfZ49JkSV50snH2HzPY1F51tU8iMmCSFHbSaO5v7o/YSnwcXhS7uj42afPC?=
 =?us-ascii?Q?WW+R/9mgiK1jObyifCPhqZMwXxBqrsb2QdryjRHcoNZtIZaLvr5preD8U60v?=
 =?us-ascii?Q?LJSVEGG/NTs0BeDnHg9nFR6O9wlVPhRa2FRw7WKyWsUjW9RZh07LGvp6jazc?=
 =?us-ascii?Q?EagYDh+vzz2cvzXwP9k0cso8jM8SAXuRg60LfroOBdY5fYRwi3FnhTWMdeYT?=
 =?us-ascii?Q?FsFGYgJJcbmehib1dmcqloFVAzFpgkfJ88ZOK1jtWbuyQaxIRhnaNqLIAuRq?=
 =?us-ascii?Q?+fgphDqk93I514I6TuhzZIc4RXHiuGC5/Iy8OeZ2A2HPNT/qYpxLZRr9cgLT?=
 =?us-ascii?Q?/apz9Z0J+TiBJS/wQrw5ZLdHSBBVWrJ3Q8ZowkJsDWeU08d3afqTOQcaNWQd?=
 =?us-ascii?Q?2q7OD5LtKyYpIegVl/EA2xTGP2f/2g4G4U0ZM1oX/zcKBOzOgOfSmHvjO628?=
 =?us-ascii?Q?UmBC+yFID25CqOZ7B7oLmDZyK2R6oC6E12cbtoiXjJexyAhAb1vuUZsSbr/3?=
 =?us-ascii?Q?oxv0ZjOOpeqEStFXCnRSEf8tG5qLf/LsqAvnbvRruY5bsN/LuYQQ1abRyDWm?=
 =?us-ascii?Q?OxiAVPttR02/Nhvz0rHR6pXdDCHCAN4VOxndiqVmPoHsmJp1gV9miOo2P7Yo?=
 =?us-ascii?Q?yFOM3yNy1NW8tV1DS++qKWbdGA1QZtxvUNwLnhauMs9K4uUPJVdl6OIL39Za?=
 =?us-ascii?Q?EU+FrZTHFgNpXZva7tRnMdmgDqP7qqAKZ9p3ScmjqEdZWvVxVGKDgGMLlWuu?=
 =?us-ascii?Q?TxZJ6BXNyI+Ul0x9lUePpa5VPDVC1ykt7n4YWf2rrnofcDXA9i2e02IifUMh?=
 =?us-ascii?Q?9lDUxxfHzGQQzfLsDAMnusWGXn1ssJXrl6DoH6TKYPfp4eB80fQcDvC64I5F?=
 =?us-ascii?Q?wd+JJp9bAloip+JbJTNzqdlbLSqR/a9V1R1Ptrgi26GE5XLRHC7ebxKZ8+sO?=
 =?us-ascii?Q?KcdTzqit8p+QKKi4b/iYgd9iXBnbhchnKTGkP5qoUSmlr7H8CQp1N8LVlTiX?=
 =?us-ascii?Q?mA6YJGy+efkStEPs9i0UPOJ5F9hOqZSrJ/v+Plp9AGt5daKAkxJpGfnU8RyN?=
 =?us-ascii?Q?RmjqSS7naio+rU7Grdjmssx1E2sZdiWzWSs4pR3/gz5voAzBf4Y7fBEQ7kwk?=
 =?us-ascii?Q?I2qO00GKjrzzmr046+9x9HbKpxBa0jfB9uMZSkOw36LoXZgex9pkuYXng5mZ?=
 =?us-ascii?Q?4DZtxdx56FFkYxKsbRiFsAclbkm5Pw6/dOljmkdQ4h+8oDCwGsE7Cm+2X6g6?=
 =?us-ascii?Q?MY0tRlf+shWclKLMy2HQl8ZXsvaFOEDNUxCKXHxBD0LcBQgKvll9zhjM+NEb?=
 =?us-ascii?Q?Gg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <947E74B81EA8784A8D8228E770AAF261@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YFY1YYC4Zc1VlWZBWKqFX7nKhm4RwVi3oeryEQGqMDL8DEhNzDeeJgrpx9ZwhbI2HwLyx8RBJiDoP5MB6MkmkF4j+fJhaBZvLvU2HzUEcdui9a4jSeESXHkF9GyfuKS6BcxkDQCWz9WRV2yNoIvzYFawnvvkfQgx142Ph1nj99HnfYej0yjOvqmp/Po1HSWe7RIiOuarWh0hENt1aFRu81UhPSIfkl4bR4c41OxgeKoGxlGQu+aMRhFz5m8NtYRUcp4FC2rm+DLHcr5JGnT5Y+BXDBx/lism9l0m09ElRDEupAIkIYRwyXwaZmEW391UB7mHTt18XlhUlYIqZPCy26NLuMUfhYmFBL03VlLDOiOvRTcZZizL3qY8IMywmdow2ayBULJ72UJtcFKNk0UuyiPJZf/DxGrAgm6yG/QsVKe6NOKdDThGddXor770HcOxmeW6Jah65MnIlFC02yPztwuCcbyBmZxQE4WiLjbD/sW+d5no8vkM9kURLGoN18E/xDcexzJiSbznDnKDdnqxafieBXfnK0OQw+cOdxPFOfhbWpKQWNUxmJ0w+FLauJOkdORLzYTi+Jf64TeI5WzRhUILFmID/vMPpG4Lk72u/2s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f35fe8d-939a-4b61-af03-08dc4ce00141
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 15:26:55.6624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qIDvgKfG9hJp3X/JcSgvA9V1oIvJoy3TdYhCElBcJouO53fPJFoEewcQUvgxEgWFBGIat95k0h5/ry5nCIRbAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4945
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_12,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2403250085
X-Proofpoint-GUID: GX2yEmyF5hZF8068qXdpSStdw4GGNTcP
X-Proofpoint-ORIG-GUID: GX2yEmyF5hZF8068qXdpSStdw4GGNTcP

It's apparent that a number of distributions and their customers
remain on long-term stable kernels. We are aware of the scalability
problems and other bugs in NFSD in kernels between v5.4 and v6.1.

To address the filecache and other scalability problems in those
kernels, I'm preparing backported patches of NFSD fixes for several
popular LTS kernels. The backported commits are destined for the
official LTS kernel branches so that distributions can easily
integrate them into their products.

Once this effort is complete, Greg and Sasha will continue to be
responsible for backporting NFSD-related fixes from upstream into
the LTS kernels.

Here's a status update.

---

I've pushed the NFSD backports to branches in this repo:

https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git

If you are able, I encourage you to pull these, review them or try
them out, and report any issues or successes. I'm currently using
the NFS workflows in kdevops as the testing platform, but am
planning to include other tests.


LTS v6.1.y

The v6.1.82 kernel has been updated. This part of the project
is complete.


LTS v5.15.y

A first attempt at merging these patches into v5.15.y was NAK'd
due to some SCSI changes made on behalf of patches to NFSD's pNFS
block layout implementation. The series has been reworked and
retested.

You can find these patches in the "nfsd-5.15.y" branch in the above
repo.


LTS v5.10.y

This branch will need the same reworking as nfsd-5.15.y. I will
start work on that once the v5.15.y work is complete.

You can find these patches in the "nfsd-5.10.y" branch in the above
repo.


--
Chuck Lever



