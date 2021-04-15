Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C53C360B8C
	for <lists+linux-nfs@lfdr.de>; Thu, 15 Apr 2021 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233411AbhDOOMj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 15 Apr 2021 10:12:39 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53268 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbhDOOMi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 15 Apr 2021 10:12:38 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FEA4cM139439;
        Thu, 15 Apr 2021 14:12:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=986KpgbDjCdhy5qnngfZweEgkgBoMwxWwMJUQNGjEu0=;
 b=Dmsp9C72i7VddXmGowOSgDdSEeNfKBOHyKq1RljckqRFnNS3jJK8gZJzkwWUF4CF174p
 oxAe+Rj2rwYk5eTXJMd9NOlKW7wGxQXAsIZRFoOJ4AgJWj6IyhJ8DK8wu26NBXeZupN3
 HYJ4nPzjjzPduZ5MrTWMU6cRbWoP8pDbstAOorLO4o9WiHUINqz/4arK5yZ2PzKKhdVo
 4QT8ue9d9+n5y09NwTfsImEv5AMO2ABT0Tso6UX/jmAikQNhSxUYMvKvcm7YJWHfwfpM
 NXPo7WH9J3oQMi2oY0fdzMgtSENJNrUkqjerY52p58fz1uismc3656v9OgURSPmQxlhw 6Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 37u3erp158-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 14:12:06 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13FEBpG3134616;
        Thu, 15 Apr 2021 14:12:05 GMT
Received: from nam04-co1-obe.outbound.protection.outlook.com (mail-co1nam04lp2053.outbound.protection.outlook.com [104.47.45.53])
        by aserp3020.oracle.com with ESMTP id 37unx301bb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Apr 2021 14:12:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBYOugXxJYvPNJsbz3A+L5B/Z7tCRFTHp5DQ8tr+SIXUClUP3jihrf9GsrULTFjtZIgpaKXWRai/79/LJ87IcM01TPwBZcSyRBWoVoA5BNSS5blXARYQTc8qwEa6BGsE80r9O4r1KIg+udhiJiYZVJmxGuqib2V8G5i3fR4ZSABUzDYsU1EHj37WuWoyTYmrdXPPDXaOztGK7MKMzlEZk/lIPb3EI09iQbseV1BW83yiG275KXWjYzZ3uiEcTGzh1hi2hkNdRNaixdx7dcO+pXPejEe5+5dFv/qsvSGs8oJ9P4OsVAygSqhWrfsmFpk2vUM7p7IrC3NyLAgN1XV0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=986KpgbDjCdhy5qnngfZweEgkgBoMwxWwMJUQNGjEu0=;
 b=E2swB0w95D1Z+pYdeOm1nTONKty4lu1V7O7+T/twND9UUArCj0FYQGft2OnoA+SiZ804jvkAWf5xYJBmAb6Uqw0/TC6y+RMj9YEBdoR/kb26tdIV5UkmpFKNRIS2nXG7XldKEcCoIbzhTv9S6yr4CMt22vMU0kQaRnTTPf8RDnAn6Hw9/ngZknlNZyKB0ZiPbQj/GuCH0mU5UapDX+1zGfigzxEyW4FFZ1wC5kF83yoC5fT5o+eIaVTzpZdpuQyVmH6wPlgxgwE1FuiuPaUBoURIaxMUJNvtLn9WsOey1yNAJhi+E7Z7HlQasu4kmeCGA825pgSsU4Yjy+MF7F1UUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=986KpgbDjCdhy5qnngfZweEgkgBoMwxWwMJUQNGjEu0=;
 b=lci2940shaqQdNfvF+ly9/pq4+078t1wGtG2xTkswc1fnQYHKexWHtF6Pd3l6D609sRmuC6sg6X3ashBkFaQYJ2bia3dSExcNhe08v7LJ6k/drAZ3r7eI+7FWqgtNsnJ+f6L3dTiwy/jYtVhOb9Zx9N8QB0PcUfY3lKPRLOJ5mU=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2967.namprd10.prod.outlook.com (2603:10b6:a03:87::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Thu, 15 Apr
 2021 14:12:02 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 14:12:02 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfsd: remove unused function
Thread-Topic: [PATCH] nfsd: remove unused function
Thread-Index: AQHXMdK64dtI26TJPE61CXRrhE4Lrqq1nvWA
Date:   Thu, 15 Apr 2021 14:12:02 +0000
Message-ID: <B0507BAA-EF6E-4A88-8799-9624DCF58C7F@oracle.com>
References: <1618475904-104579-1-git-send-email-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <1618475904-104579-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.alibaba.com; dkim=none (message not signed)
 header.d=none;linux.alibaba.com; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 971c7b27-03ca-48d8-b7ea-08d9001870ed
x-ms-traffictypediagnostic: BYAPR10MB2967:
x-microsoft-antispam-prvs: <BYAPR10MB2967922EF78E5E27EBC1CF92934D9@BYAPR10MB2967.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DXwXgkmjbjpfik4uSOvYRYilwOYNcFxSK8/9aOizGrhHM87WuypsDn9QhUNUUzk/n3X5KXclCYuAN8LqijywiLmjv+3YU26WLorYFJnUcUgtNITVA1QQEvW9lBoTFwcZhZYUGI5xpyg6TmjvOdlFw6O35B0RgGgbmni7WGU1H/Vvaej/8tMXRIykk6a1HWHtUhh7zAkX0CaISzEwCsEVt2hugOhSHqEE0z5EDyv9ymNjtCdHBPHaeWFhN3987ZjJZf2qx9E8oAlH0ow8+L/hHyK1zJUQnl3PwE8340ZBgjPCh8MlUiixVz+QceIU7eKXCVriXpeW3njXTeAMaoz0OQ72ddck08k3EAxSqniiDI7CQQITEKNk8fm3jLKvrtVZChyOb1qz27g+7EVQ8798OVmeixk0sScRT41YmXsnegccFCztWaXtnxhsBYr5R3vFH5Gaa3pUw+nU8W1vgcVb7wyEGsjafCvZCzgnf6WbVPo4sIczQ6r4n/Qhg11vshb1aVp81T8IDi/VUb19YoPwbKaYq8uF/y4zxukNiAEzfjOWIcrOHIjiPigqhh6FjlWpiXVYoJil528I0BjM8RTIsZ6h+4MF3WoxsbebfoXGb/aJ2TBO05NaGpXwoMoSxwW1rUVDr2K0rOH8Rj+ARJ62h0cPfYeKulq2zGgFevb+I4c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(2906002)(6486002)(122000001)(86362001)(6506007)(33656002)(6916009)(76116006)(6512007)(83380400001)(38100700002)(53546011)(8676002)(66476007)(71200400001)(8936002)(5660300002)(4326008)(4744005)(478600001)(36756003)(26005)(91956017)(54906003)(316002)(64756008)(66556008)(186003)(66946007)(66446008)(2616005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?bvd6/LkO48cIGsUR/WP1bc/SBtmWH2DwfW1/vuESiidZX4ELmm1zhIjk6nsf?=
 =?us-ascii?Q?xVcM13mmHIRm//Bq2+9XwuBpFjHgS9v9z8yi6t/Z6ENXjQMKC9bIk0U6Eu33?=
 =?us-ascii?Q?6bVlUo/7oDugoq8+/xTwBB+yO82gkFDOLhSRXg88DqUvaNzkdml6WyW7erYW?=
 =?us-ascii?Q?X91wfVw1v1DfW+y4BOQ4UXU2FvjuBmPsBCel5rZUOHJeMx5Wepa6K8JFFnwG?=
 =?us-ascii?Q?SW41EpyRu4+CIHbQhVsoVXGF+5PIjo7Dh5vKlu4iR3/91AhpwaZYrEf3pMAB?=
 =?us-ascii?Q?zJFTdeCKwIzLuC9GJgEZg4EYhw9acE/DwORu6qFZ2+GF/mU1J0o1LblP7Sl6?=
 =?us-ascii?Q?UT26cGxi4xjtbWDipN6WVIaHvbKQWJUhgVQWQ3BAlA1kzdo2zPRHsFE8Fdi6?=
 =?us-ascii?Q?bFwrTDn7TOlwsv8ff8psYsgQ6HCSRSq6rc863WerHZjmq4bCUrxO72dGyRue?=
 =?us-ascii?Q?SOd9PM8S6cFQ9iNPFjaiImXECgddEnuqoQhM7kQMQKKazz0MKc6hBmH+QO3c?=
 =?us-ascii?Q?Sa1E/ytE/BjD6oMEo1kSlLaqjPPX5XGYiM3ZloLZXua3B7Wpcq+HPJXh7Yd7?=
 =?us-ascii?Q?1TteWIknAF3CN9oX3PSrOjYNf3e4qd5XRAR1s2iHm6a+S76sbDX/oEXrESDx?=
 =?us-ascii?Q?hG5cBP/pxzR7J63Kzx2FWt7RIeMPQMOkqhHAXoUFSRq6zToLApCav1aVd/RT?=
 =?us-ascii?Q?9vkRrey0eWNdATZ8qjFAbfsq6xTgMZMD9Kn8NxR/K67eRisfgnBl1h5WnU/W?=
 =?us-ascii?Q?SOLMvTo0gLXqEMhAFyz3uoIWewtFdUmkNql3ifQR1uN944TqwLLjg7dOLOnC?=
 =?us-ascii?Q?qElJZ9BNQn75geftqYEHaWdCV/V9hBnCYn4WOJlkbTINkUJ5fBkkl1sJWFP0?=
 =?us-ascii?Q?H3LylUxahNuTLkIU+O1UI9cHZaP5DtYs6PtIkVx55vpy/DCSzddL8PfshiKL?=
 =?us-ascii?Q?npAsluoVl4mpytxTJ1z5U3WliZePmCiNHbNV8wdIAUvvDi2vHjQEl5IdKmsM?=
 =?us-ascii?Q?zya3uIvWor7TlU0AiYvjOqf4vuRqMkDyrMNzInMz9CBQ0Of5IeBpT6yVXtgO?=
 =?us-ascii?Q?Kb1gm2YxXIUmidJ0zxZaIDKvetIx4jhzaI6aFoMvr/itG7c3prqiqupPRhgg?=
 =?us-ascii?Q?LWJwxIzgv76IEU55wCgYu0Y8g8uKvHSrykLTAq5mnHF+1BueMID0PZ8HVu9c?=
 =?us-ascii?Q?4sGZDydBxq3WwLh6ViZCzefql6Pa9KFHhnXZ3qQy9g6bKYZUV4aJ8DI/CeTO?=
 =?us-ascii?Q?iWhnuPXzklyEglffw69f/HHEiMPXUjjf6TiY6UJVO9SAazQCfSRB+LB95Ck4?=
 =?us-ascii?Q?8UdUIY+fKqx/jhOcgK8iXfW8?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4CAEF509296F2A45A3E3246AE994A607@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 971c7b27-03ca-48d8-b7ea-08d9001870ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 14:12:02.2024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kudrtus8xuWZmzd8YfisY4dEzapIFPzKOfXNdJ+dNtf8pM5bIaBH3AAny1AnPJJcLd9cIJE0WpN5BU5YZTyLXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2967
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104150095
X-Proofpoint-ORIG-GUID: hAkljPccIy1ukurkTr1sIPOYWxeORWoc
X-Proofpoint-GUID: hAkljPccIy1ukurkTr1sIPOYWxeORWoc
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9955 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 clxscore=1015
 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104150095
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Apr 15, 2021, at 4:38 AM, Jiapeng Chong <jiapeng.chong@linux.alibaba.c=
om> wrote:
>=20
> Fix the following clang warning:
>=20
> fs/nfsd/nfs4state.c:6276:1: warning: unused function 'end_offset'
> [-Wunused-function].
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

Thanks for your patch. It's been added to the for-next topic branch in

git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git


> ---
> fs/nfsd/nfs4state.c | 9 ---------
> 1 file changed, 9 deletions(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 97447a6..32b11ff 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -6272,15 +6272,6 @@ static void nfsd4_close_open_stateid(struct nfs4_o=
l_stateid *s)
> 	return status;
> }
>=20
> -static inline u64
> -end_offset(u64 start, u64 len)
> -{
> -	u64 end;
> -
> -	end =3D start + len;
> -	return end >=3D start ? end: NFS4_MAX_UINT64;
> -}
> -
> /* last octet in a range */
> static inline u64
> last_byte_offset(u64 start, u64 len)
> --=20
> 1.8.3.1
>=20

--
Chuck Lever



