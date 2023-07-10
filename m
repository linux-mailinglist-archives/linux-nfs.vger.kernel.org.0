Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4691074E192
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 00:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjGJWwU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 Jul 2023 18:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGJWwT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 Jul 2023 18:52:19 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E8C9C
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jul 2023 15:52:18 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36AHTaxt014938;
        Mon, 10 Jul 2023 22:52:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=gFAfavMXFs/N2cDrKRvVjuszeAmu1TfEqTcke0KSAFo=;
 b=emj+dUra6DFokxpT3m2oYQa3dY6C5uysNfapd/GNMMGXN1EOUI8js4vrfGbkng+lpFES
 VcPJUHmVrAfTEo39wVdOdWfVuEb0PoasGEVhmIPEAObhTjSXYgdn/r2ZfmrHAWcPbHLN
 4Rt58avilPhNmgmlURq8bZszUBWquZ79QQqFmZqzAGRkCgBIBWvGTJH9e0h468ymcu3E
 B1ErhDEpLLlAtLdW9ZLdtsNC6HcInioRuWqe2lbSQcFxMc3WTvXOxqpV0zbX55AjN0Y2
 DFTFmUZI5JBqWm1sOPVQ2nH+mLHhPS+ofoHBW6gQf8hb0EkLIZBvKx0QtNRlDKtS9mAp cw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rrea2sp3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 22:52:10 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36ALJdU4033036;
        Mon, 10 Jul 2023 22:52:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rpx8abx94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jul 2023 22:52:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EB5OWjFwbE/3Adi+8GvfrC2wjthcAD0wyPwdq5FXjUKePMW4iJorCd6GoZxCoZtI8ASnYTItuiweFgJHnb/ZKsJHUQyJJil3OYjfR4i5tHKiTqkYHoETRlO52l+ZdZPe8ZRucC1FTThMmYACUYhcKev8wVhwczJb57Mx/vdqR0VliT7Dcacl7UpO65Yz105BQyAOXzRp2f8jnWqvmKZ24J0D33vVLl06DQWefRWyyPUYHCXl80J7KS3IPBgjxqp5n6S5pNYx1GR6T1F/GbCvkg+M+gRIYzPwzHv92UDX3XH7vYwqZQ4xbPsVN5n5mBXptWu0hVhw5WfKcrPweHV9WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFAfavMXFs/N2cDrKRvVjuszeAmu1TfEqTcke0KSAFo=;
 b=cJWYlZLM6y+2RLp9Gef18+CT4qXwTCaXYJyyi00B/jQNcGsywn+EE97q6fm8fnZrc2MB/fvEFp7oj7gs/+ftMB8Y3kRbJ2dTH4dsATaemn4CENeMK3x4qI0QUZf+q4ct+UHIi8oY4nAa2cgOnSfg+fYHaJNg+y5PtXsAbg+fDY/krjF65GRXrd9JHCf20YKKlwAq/XaaHzucMDTkW/EMzKLFtQoiu5CTIJJW/rwOTeu9Fc18u/kttTG6cJ7rU9n4gvb0BXlT2Wt79XMRgQn7zhxUlu+ZoiqBDnz/zEtfHjqqaGg9QK11avO+mSZ9tRYZZPvAwX/dPsVdC23nch57ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFAfavMXFs/N2cDrKRvVjuszeAmu1TfEqTcke0KSAFo=;
 b=H6NUrGHdTUyRHfzJ4XFr+N7zLFQPLL8FxWKyk3OqR917DeVZLq5wevS/xxB/sAhIoEn4KlxlJf2+nVLg/dOM+2gJWmW7okyOjMI0w6M2XGbzRuTY2viPk1mWye4ELqAv+n7cWZtIR1TDnihIka6iuysdqFfAqljOiKk58nFLc64=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SJ0PR10MB5860.namprd10.prod.outlook.com (2603:10b6:a03:3ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Mon, 10 Jul
 2023 22:52:07 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2107:f712:a7c5:9ac7%3]) with mapi id 15.20.6565.028; Mon, 10 Jul 2023
 22:52:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Chuck Lever <cel@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
Thread-Topic: [PATCH/RFC] sunrpc: constant-time code to wake idle thread
Thread-Index: AQHZssdRahirD7+pPUW0IQejq+CcU6+zE5KAgAB/toCAAAgwgA==
Date:   Mon, 10 Jul 2023 22:52:07 +0000
Message-ID: <2211CC3B-806F-461D-A5AA-E95E35E1E408@oracle.com>
References: <168842897573.139194.15893960758088950748.stgit@manet.1015granger.net>
 <168842927591.139194.16920372497489479670.stgit@manet.1015granger.net>
 <168843152047.8939.5788535164524204707@noble.neil.brown.name>
 <ZKN6GZ8q9NVLywOJ@manet.1015granger.net>
 <168894969894.8939.6993305724636717703@noble.neil.brown.name>
 <ZKwYhbo76v8ElI1b@manet.1015granger.net>
 <168902749573.8939.3668770103738816387@noble.neil.brown.name>
In-Reply-To: <168902749573.8939.3668770103738816387@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.500.231)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|SJ0PR10MB5860:EE_
x-ms-office365-filtering-correlation-id: 7b855a57-2d4e-4876-1608-08db819849b3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lQsOHdYQNnL+cwTk48IZNtZ3KKLMf+9PPrfiriwUsPHzk3yX7DhwPW3/oAzfJ8nXWZSCCDGiTrjS5WrJB7DP7eonehW8Sd1NWSdMTQkOGHEieRJK+VxpGuKxKXgx5bbeIl6/JylUDXHzPhNTHcytP44bQOzfsYHasGCR41M6OLquWNk8CcnUjbjH7ytC3AD/8niG62yXmW6c3Zw7HJviWHoNmwiOfFMpeSde+5hoDinaD/mSx4QHGf1b/1Zgz+SFSjt4QLBtAy3Kyb8oLJTZSxP1Kmz8ze+UbUARssSrLlYHcKASZba0A73d+AFsAxHWldlQDtfIZtRCL4mZbtPdcu1i7YQwdFt/HC3TI9NFQo7XN+63CzUcuU9Zhy3CVindHNYrskM2GnqEiTYYNB61ssR6LB4XAeHN8mKdgWt3+kGCYXoRCLd5VSoAup3OhpYVN+OtysCkmyFRPk5rYcIJP8/Gxn12auZETPG341fAsFNfG4p5HiZ1qYARtQWEkRPsSmjvAV33S7V5GQg2qnxpM86AnjT2OZXnolEH8nI/hQvZvSeOBLids9MuZuwkW+YpVnMK3feWtqveSRJ/kcgbyXkvYPtM18Uf85kC8RdujSPk/6F+KCzVo2/m7pqEV2+I+PH2324lbogJMONOomBWFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(376002)(39860400002)(346002)(136003)(451199021)(5660300002)(8676002)(66446008)(76116006)(66946007)(66556008)(66476007)(64756008)(2906002)(316002)(4326008)(6916009)(91956017)(8936002)(71200400001)(6486002)(6512007)(54906003)(53546011)(26005)(6506007)(186003)(83380400001)(41300700001)(4744005)(2616005)(38100700002)(478600001)(122000001)(38070700005)(36756003)(33656002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S8/cpRpdfgGvGtV8An6GWMjNBwA1feXg7s8xuuN7qQYgIL65RzLEPkPI5YZd?=
 =?us-ascii?Q?6RVqNU5j8ndzmqwtVgIUNlNkaPZAfiaEd4VolHx7OLhUXO/vXTVJZt4wi/7T?=
 =?us-ascii?Q?JodolFkVNUOo48Nyc5Wx/GExKoNFo7tlCglVHL5lHPCr9imOO1e6uYldYbTy?=
 =?us-ascii?Q?hRal9CikpLbS12Wg6JfAZOOwXvRbDTy93mdZCaihfIqL9vQwrMgD2Fmkgwwu?=
 =?us-ascii?Q?QDsz0PXGoKwgcQcLrmvDwIhtoVKXagh+mRNeIMaefyQ2FPPq/NOoN0wJll8G?=
 =?us-ascii?Q?llBaq65x0IvPHFtfdi2YfkFFt2t5C2PIX4bMgdbNdlK7qArn0PH0S5sz7c0V?=
 =?us-ascii?Q?JepqVKC+dGdJf3k5S65Pc3KGIJhAvzbCtjjWd1azPiMffHxwnKPyulqL3A+j?=
 =?us-ascii?Q?QePNBkrCEhVGiZ0hIKFbfrffrAFCE6n+K22Bzev5dcfUGmDev6XuTU+sS9sZ?=
 =?us-ascii?Q?+Zv+vdMfr+6AiqffNLko0fw+47d2ceiAo5WmTbBSyZ2HshMXoNBOQy/hIA+M?=
 =?us-ascii?Q?qAGH6EWWL6+gwoeaeWyj/188G4tdbctGFh1GDn814MvGi5svdAh9R2MWlb/8?=
 =?us-ascii?Q?nxRpQmQWLHpkBNdvUYp7FO1OnmZ+2wweXrl1g6sD43HbjXWvE8H1aYplsTuf?=
 =?us-ascii?Q?OlvPLY4gk+G6bMpfebqISnGFS+qOCrFYVApQHD8Rl4c02qQrG4MxCG4R6guC?=
 =?us-ascii?Q?NCcSMcYoFtlFZe6irdoXELcypO15ciXPBDl45btBzIXMEjjltGIsbsLvP/Oi?=
 =?us-ascii?Q?C3BCsxvu28btCSe5DGIWwQb9CocsdD01CCCFmRORroGJVGGX0vy30rm1vrNq?=
 =?us-ascii?Q?wjNFrjYY6Zu0p1KChNWZOdC22QEwuuKCsANqvBi0f6Qw4Cr5+OoDjP96KkD/?=
 =?us-ascii?Q?U6i3efOibpCDUF8HWaVEwwC31dhiDk5FhEJOOCh3qXR3J/4QBn80LVm6ij2Q?=
 =?us-ascii?Q?Bn1ahpZdqSLQ1zgfIY3nhzcme+bV4/649hxixMlf2TFgN/Cq8dHG7lF6GWrm?=
 =?us-ascii?Q?xrHE70BB4BAr3ELDFb8wyyCkIuzQHueU1SBN433ar+Jywvv7zlcPYy2pkzkr?=
 =?us-ascii?Q?jE0Mdf+76KiFJoZhBuPKOZgRP/g9lqu/ZLJS6LBcT7jUrdJzRCEfIsHSwOO6?=
 =?us-ascii?Q?gAKhMlbgJBDUFJRlIHRiPhuM/nC4XZnkmCTmjwsXC6uqYSKNXmvUD4WFY9q7?=
 =?us-ascii?Q?XsnL/6zC/E29RvFUY2pXuu2suJu17CgkHH5CDXe0C1xtiwBbk/JTQ7XFOuHV?=
 =?us-ascii?Q?Y0xXwntbg7lIHSiYfU0nZZ5hDyd679uIgu3cWmyXlsCO/+7nlRQv4azkqR4O?=
 =?us-ascii?Q?27PiS2Ry+lxk7JEJ+aARUcrU69Z9lXkLedYttM4x7Wzcm36mwbZeyoH5P8Pb?=
 =?us-ascii?Q?0qC5VI4bZkCTwv/xzKuFjry3ojBR6xjl4U+M38oA+Drc8l54tCT+jGZH5qLf?=
 =?us-ascii?Q?cIsuUiHYqmXx/rXqM5VK4Jnbg6BMyH7yPuKF1XwYoZsVGj4I7W+nG+JKgZEZ?=
 =?us-ascii?Q?rRtR9nN7MmlGMTguLJRcVUoht92h5BHezORgZ+qtvWwEl67L6Y0bUXIFkQxt?=
 =?us-ascii?Q?HtJyfQnDQcVcrqYBcwGOGe6vDU/6LmSytVCflMagDu4ncC8xpxPtiKxofacM?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <472F4F4B03E72C44A7F2FD8CAA43A0DB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VDvq63yVn89e5+yQQui7iSBnKHI+ue7kTQzR8Ru00db4BuzEXV+dnIlO8B7Err/82vg1ZyPc5cJWVx/iSKHxWwyhSGs4BzA4OAuBwa5RTVbypaige7F/8EJrPQKEMuQFOdkls04u/X9+HN1jHLxayr2UeKN7PITas8ka4sdGJt7vrkUyB+F8J+Q6ZXNZFGr4r97eG9RoWjG9Qz0rpwgoqYqiPkIqyOwzoglc9BNPIWDC1J0lEs8qasK1vlv1JnNtSZWUePyytsPE5a/2uVnK9/oCzypRUmrVJHHzJClwvYCGFtmZx9hpjPhrFofuTKLmt6dGk210bXrAi6/NRV4eLNGPTqvYqVhbr3Z3GgGxAnRnK4nkjxhIrGerloex6sggYyOqxTFpVliOx4p1dh+gCdrhFAM9ZwG4nNYpSCfj6nCNxLjkCLLve/jG+vW7mTOaWCjLzOgUFwBjnwER6uP6AApRr+WggMzytLjIMWxxjFMY7mLxvXtM9jkQdfXXnC0GYKAlq1RGi+K5nOE/sMIc3hNUaMoLoZmcNdwNyQkhWwExj20QUC4sDKwtN9ecALkXJudNLlteQl2Ps3Wyhr9m6Q2l2y0w09r2ugePgfmrg/4OaRDLxPZRIKCwc+FeWMjZM8rJU1z70PuQXBMgwkh9ujrnaAZWzK7Jb6JVilh4rDFlJm7EvaMuAYJWTGC11vtRKf+yljiwsGWbD9z62X3Ur1W0Cpt9ZSqtzFtiYfUZ69FxstoGQNEgnlCWTQ6iSBoH/S+MHxDuzEOrYiPrT+y5WzZ01pA0D2X6riaZF+aBSb0gLuycihtr7q9SdN56ckIH3Rlboma6Iw0W9wjt5ZxjKKk7Y5NTyzeAfbXKJCsvH4X18or602xEv6/XLzYr2t4H
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b855a57-2d4e-4876-1608-08db819849b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 22:52:07.4313
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d4O2Jg0GvKCbwWzL0Zj23+wxyo+OLig8+oKCJT4mEyZTE7w8/7VN2tacxAvpjM2o23vJAme41S/sIiBLHRCsuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5860
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-10_16,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxlogscore=829 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307100207
X-Proofpoint-GUID: L7ioCQaKJlpfv7pTOLMguBwiDZuLnxRy
X-Proofpoint-ORIG-GUID: L7ioCQaKJlpfv7pTOLMguBwiDZuLnxRy
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


> On Jul 10, 2023, at 6:18 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> What do you think of removing the ability to stop an nfsd thread by
> sending it a signal.  Note that this doesn't apply to lockd or to nfsv4
> callback threads.  And nfs-utils never relies on this.
> I'm keen.  It would make this patch a lot simpler.

I agree the code base would be cleaner for it.

But I'm the new kid. I'm not really sure if this is
part of a kernel - user space API that we mustn't
alter, or whether it's something that was added but
never used, or ....

I can sniff around to get a better understanding.


--
Chuck Lever


