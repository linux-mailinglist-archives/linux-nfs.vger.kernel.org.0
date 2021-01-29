Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1F6308F8E
	for <lists+linux-nfs@lfdr.de>; Fri, 29 Jan 2021 22:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233318AbhA2VnM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 29 Jan 2021 16:43:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:34518 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbhA2VnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 29 Jan 2021 16:43:09 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TFsuwK056367;
        Fri, 29 Jan 2021 16:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=MDTDfbDy9+sEGqQERbLpw7xZLD/thXV2E15RCZzrG2k=;
 b=OlFiK96vJifB9UJfPHsKVRJusnGbwTUUDDxStgmLpfV/98V8MBqQLyGMEIeOt8o4pySg
 aWTGew3BDxsg90PkbHDUCOqOuwCfyQp+du+Ks3FHt2uj11SQFdU7LYHr8jz+ixErsMWO
 w/i0cLyt/zQor+kj4546xNxfVE7VlqaWK9acBvMcpnh/qHl/OFb0XAK/yby8HvCd3GqP
 Pspf2noSN2MFnTT/cUMt67Dh8UI++356X2kSYL6o0uaV4pQxFm2kY9ZBMNwSG4GLNyui
 TenR5lclPFnYCu6/uxyVe3F7FgogFkS5/hfvpNeTDi+nJBp0Cbo1H8A0TNvlWyOV6gHm OQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 36cmf88dww-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 16:19:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10TFuI1H112597;
        Fri, 29 Jan 2021 16:19:14 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3030.oracle.com with ESMTP id 368wr244vv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Jan 2021 16:19:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iCacVPl2xd0rrEw1gRNlpJy3mv5sUoTQfaGEDbzVz6qCG70pVInLdtnMDlK3jZ8/GHb9ffdIEShqTtPLjEEX4vJ6J5AHG2noHpTUifsgKrHh/apstTYQOTdnLJ80lpvB5uF7g9At3iwLjLVAKYG0alAMInMFOXYVaIu+D3eamUo2Uj22mjnXdkdHAhuh1YlrzjGURiI7N6k97TV7dwZuxdSB8sdrX1dtlkAhg+LeKQ7dCTrONaVuebF1Rr60mudzBZ2x7LH78+6/k+O7cXkvugdpWnpPOAvt2RmEDxYilkFzOeLYNgDXHoOy0Zq5FIGM/JpPG+sU9wG3crUSp/0qLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDTDfbDy9+sEGqQERbLpw7xZLD/thXV2E15RCZzrG2k=;
 b=DcqiTt3JbZ8GDceCG1P0LDu7CkaaFbuifVOCgN1mUXqzxl/YV46Eum5SXSenBAvRXzvxmrUtL6wGKJttD0usHEiqPMGSsM08aZBfYpLRX6+j6/tWmT1S383OeLdqE2VE/XAfbP2xbSH1qiSai2vQ7hmxsMvOMfg+VKkIoHAoozbBkYAyUPdeE3zg1Vn1dbmGtZj9EspdHHFVXNXT6t/Tk+WgW/XxJHqxOTlORqF4OnU8JkSHh/HYvFQsuiZxaY56MqdypxqOi+RWoLhupH6I3971O/r9pTFNU7EKdfbPrzF+nHDaY7hcPa1mGk5KwfgE4xYMw8r8U1Q4wISoIijdyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDTDfbDy9+sEGqQERbLpw7xZLD/thXV2E15RCZzrG2k=;
 b=OCksIMog4dt32ZIgh3hZqdndauFVGSFyBijyW4LYH6TgMnicUTqVB5ygaMh6iDUT4sllSSOz9cSoS0UumcBgoUJWDf+cj2O2+ayDnyS16dIUQ6ZGIW8UFEP5uq7lmAzuw7sBbgKeMRQVSPGT1FY4VH5x5jev44AJ8oiOAEMic/M=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3191.namprd10.prod.outlook.com (2603:10b6:a03:14f::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Fri, 29 Jan
 2021 16:19:13 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3805.017; Fri, 29 Jan 2021
 16:19:13 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: releasing result pages in svc_xprt_release()
Thread-Topic: releasing result pages in svc_xprt_release()
Thread-Index: AQHW9lp7zlCjUUrS1USJUH0XaXdCew==
Date:   Fri, 29 Jan 2021 16:19:13 +0000
Message-ID: <811BE98B-F196-4EC1-899F-6B62F313640C@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96b92995-94e4-406f-30b3-08d8c4719dcc
x-ms-traffictypediagnostic: BYAPR10MB3191:
x-microsoft-antispam-prvs: <BYAPR10MB3191D018616B7B25C89EB91C93B99@BYAPR10MB3191.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3P4fysAksJWC3fUUtE7GQyk3Q7lnAG9ka6XeBYrOaALHPxELp3Pa8JZUfi4APtsDsAJ/YU/2QdJ3mQl928myaZVGiZnmynZUc98XmQThnatau5JmT/BtJ5AXriSN3KQwZmDkJaHn0R/TVG+d55IrfS63hMmKp5S7aIirhFTANkWBKHJ3vVdkyhLyodN0iYTRgqk7iMNLdWa/8IBaXQ/SQZ6krN64hoZPlVXuSGc3cOL3AHqiv9upkDvnsXbtgsFzMHXYRgsq4LxJo+1M9FJ/16ReDthvt7b1SSEUS8HuxXsSjLNdFo3uGncjHJkk9eqYWkqQNcY3pVLJIj5r9I9w1oN2CXwePIDEQnWIZoWSBNUuRn7N42r6N6k5APiFYKS5RDl4sOZHjqIsGQn5/W3W91jN+vao9ytAMh2HWmcIAa+HnTt6UDh05ubJY3G44l8fzJYeQhPyiT8nqtXEyG4WaFjk6p+smX6t0ZHzs6QiduvvKR9dxKTqgeRFW70zYh+p4kRNx+d64HQWl5iuaV+bR4PH8Gm94GPqbFDNKgMcKEG0h6FSiJz2yiEVqtgk/qVoYpGj7oMLu9+puDa3OMThg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(346002)(396003)(39860400002)(376002)(136003)(71200400001)(44832011)(2616005)(186003)(26005)(316002)(76116006)(91956017)(4744005)(86362001)(5660300002)(66446008)(6506007)(64756008)(66556008)(66476007)(66946007)(478600001)(8936002)(4326008)(36756003)(6512007)(2906002)(33656002)(6916009)(6486002)(8676002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yKgKgwmSVcMKj6aQes6HPuS69DijketnLZDQlg63T4B2KroO0jQYjS5VpakT?=
 =?us-ascii?Q?b0EDiZKwcCfDMi76XnmwzlshpxGR0iAJOpbhilXmwslxcxssyxzZvp9CN68c?=
 =?us-ascii?Q?9M723HLiwPNgf70rpZJdXcrnSZZcg5KlUnqZ+TZZluFTLhdW4NAe783FZ6Mx?=
 =?us-ascii?Q?BRr/xXn25rYjVw3gtiBy4pMpot0cZvYitv1p/47wJ8KcwG73DuzhdayuLb0j?=
 =?us-ascii?Q?cIKVlhvkrGv2ambKr0ZCYr4Oe/6DGuD8y9eoB7kXzDwLYC+25xLdXF0Uwayw?=
 =?us-ascii?Q?ENuFbyfLIKzi8ETUYQXp8B9+r7zDLeXyHutTzm78np8u4glsU1GL2YMOmdCw?=
 =?us-ascii?Q?0zviIlA25D/knHvLsoa/fYTks2R8exZ1T/xE6fNOsvDlnPNsQy9xZ6QZYMg/?=
 =?us-ascii?Q?PO6JgnvVGBwKddVetg5/7JnENlWLklP4eCKIVht9XMob2tYjbXsbNY2TeqOW?=
 =?us-ascii?Q?Y6DggNclz6QSCzm5YuP42ow3hZWXpAupiLwfiAkbIaDDVOdkl0pbiKo3zikJ?=
 =?us-ascii?Q?1xDf8YLv5ojde70HGi8GrMj+U+eIy6Dbj3ZqATi/v4b1iTalg4/qI8zB3XGv?=
 =?us-ascii?Q?Jettje6fivtfrx2phAp6Y8H35CMW8lFH8gxMz8P9sUkD7/f0r43PGFzQD7gF?=
 =?us-ascii?Q?PWK2/F2vF05hQfKOHjh59GNPdnZulGBgV7n+Y/BmIRIGYMQjuK+E3YTF3zm2?=
 =?us-ascii?Q?PeDMneJj+Wb5gOluw6EExrtgLM1S8KlkyDmlrJrpA9cZUdGCpmBfIKI5FxkX?=
 =?us-ascii?Q?Z+QO0nLh6zOCg/fgYYgYxKIxbXA3+IQNJVXZz9Sj4SAWkOUZu8F7XP2oVaoc?=
 =?us-ascii?Q?dYbYyq8qPKQU4rj4RXocTojrUBCfkjXDG6ED/Joxlqpdf5tVsSuNolrUFOV3?=
 =?us-ascii?Q?4Ng3zLB3/BxB26PGiajJGL9m26AnV+KvfjTSNDcdRo+DcAP7uuipDB+H7ldL?=
 =?us-ascii?Q?ackx3llejzhPtubzo6k4A1slNLyMLjQJ5QXbEgD/AOaNv1aq9akDVjyCpWR5?=
 =?us-ascii?Q?poFv3BIggyxuZSSwAUR6fpbfINX9XMm1bGH0nBx/doVhL5JmBl5Fk1bEDJcx?=
 =?us-ascii?Q?tOyHfQCtYPu05xhdHRk6LHlBcNnu8w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6215B8BF31D4D448B111E598BC0B5BFD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b92995-94e4-406f-30b3-08d8c4719dcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2021 16:19:13.0150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N/nskJx5Kv+zkyIwkARvMPp49LzuseF+NMIjnO0tyeduclcZIw9obHGy6qJ8q6/aa3dganVnZbCfiZWcJ7e1bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3191
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290080
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9878 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101290080
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Neil-

I'd like to reduce the amount of page allocation that NFSD does,
and was wondering about the release and reset of pages in
svc_xprt_release(). This logic was added when the socket transport
was converted to use kernel_sendpage() back in 2002. Do you
remember why releasing the result pages is necessary?


--
Chuck Lever



