Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E94797E1D
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Sep 2023 23:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbjIGVvf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Sep 2023 17:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjIGVve (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Sep 2023 17:51:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702EE1BC1
        for <linux-nfs@vger.kernel.org>; Thu,  7 Sep 2023 14:51:29 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 387LU1eo028430;
        Thu, 7 Sep 2023 21:51:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=wIv4vb6Oa39QlSwS13yBKWKcrND3W31yBoCLS9VqL5Y=;
 b=zAJwgirixdDXKoe6lC1v+UuKDzEjoC1JuJwH4C53C8qwvu0Jnzb885yQRqG9H8f5nV9X
 ggnQLVyAjLaEFl0s0G41jN77AVpu7tGvMvEDRcTUmLwfKhUU3kU+kDnjhpkGuo3mf3xl
 LsjSTFFeb9DfJPth6YOEvMBxg9HKFYPieqTPU0lBqmZjS9rckrtfL3osRBHKEjrTaMNw
 2FlGM0r+2mvxTIlInO8Gq22Fzas28M7SYk0TTcPOVvaHFdsdtudRNCUI8b/KM0bs5JVy
 Pe//NzShM3dua2QXOSOIFzzGWMHfSrl18AS6VqZMyf1yYOTmNeifYVuDPxflF47xztdf BQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sypg0r182-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 21:51:22 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 387L1WoQ031073;
        Thu, 7 Sep 2023 21:51:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3suug8srtw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Sep 2023 21:51:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH4X1B9yXrMQ7qkijhxJsTErz1RQ9Dd7Ukbdkr9X5ZCjBwkHQpy+H10s/hPLjoM9cDxKANcyeybyUCj0TtUlRKUMhaZYN3++LM/aW6i0v6IcqIHZHEbrEauedTQUWq8IGBgwvrMgITS7IKv0xvz3bd+nUE5u3TPrZ1tnVaKz8ir8nfxOZMFE4M4GrRtilCLpYHJk0o4g4pfF8c8v468IvAfNOrkPxx63mvEvrQbFAPTtuxFvsBvma7Jg4Hxyx7duls3bv4dMA6KB3FXMhDkwhK8r5LLLclZLmU0nmmgHpgRjtff+CT2nIWeT+t4hGJ8E2K2dN3ODdIjCrqAzRXyrfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIv4vb6Oa39QlSwS13yBKWKcrND3W31yBoCLS9VqL5Y=;
 b=L3DxHbqodCDiSMEdkghmRIS/PvEhNpAKmbgCsSPQYWLBDEbtzRy5rdKLgnwQ2SXuHDQk0HoudHj9FEdbArDbVVMlHtLqRRJ3W39QdM44tV4uUgNIvTUUHL1WVw+W7wrqIg3eB8sfijHfz6xeFIoTh33IMNE9vQlNYi4huag+kNf0RTC6x39+yPIAIb1EBXNVCcwJyh6V83UtQ4O2oZnYjz1v2bY87yRaiT+9CFLY2XwggtbYJizh+pUveq5Z3Ls9ohpVzbh+H6D0Nt/PnLa5iej2I1V5D9pry4KkBNzUT0JJ84Ge53rihXtgcZgTRW97HiuVDEYZTo3nuWbfEilkUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIv4vb6Oa39QlSwS13yBKWKcrND3W31yBoCLS9VqL5Y=;
 b=BBuPpIVovvDjdSrso8hkIAksYaoSAHEG+Wx4I0rkw1dvGnSNvrAH30nBWV+MEoUCMwO7XOPZtKKz2uQHZM7Lw3lDfXjwL6hC3zTILzNpagpAYxevMHGVgTRb00MudBueQB0qWaJhP5qufPoZsaWjR1DM4xDCufIcvo9O1lDaI/E=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH0PR10MB5260.namprd10.prod.outlook.com (2603:10b6:610:c4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 21:51:19 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::2990:c166:9436:40e%6]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 21:51:19 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>, Christian Brauner <brauner@kernel.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: BUG_ON() hit in sunrpc
Thread-Topic: BUG_ON() hit in sunrpc
Thread-Index: AQHZ4AjglDLFb5i35EOVcVfzT1/0ErAMU4uAgAMvPICAAFtVgIAADKSA
Date:   Thu, 7 Sep 2023 21:51:19 +0000
Message-ID: <EA6B6884-C189-4E70-B1C8-1FDE3D982B99@oracle.com>
References: <20230905-netzzugang-kubikmeter-6437d53204a2@brauner>
 <615A8DB3-F931-4EFC-A6EC-CC4DA3766D7A@oracle.com>
 <0B563F93-A30A-4BFD-BBAE-F712F8011E04@oracle.com>
 <169412075594.22057.580928756094478654@noble.neil.brown.name>
In-Reply-To: <169412075594.22057.580928756094478654@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.700.6)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|CH0PR10MB5260:EE_
x-ms-office365-filtering-correlation-id: 733a3c3b-0b52-4043-7903-08dbafec91b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AbR86T1CZEtEMD+swJUxFcedUlmf46+f3RnV4iCxBb9goyb9WJhC9q9J/lAEP9DgJIQFhESqwnrbPUP6Fht7O6bYn33QGsrQARI590yvMwFSGv8hCjfKDFkp+gQDwmYByrY/8WcYq4D+QaiHH2qa5HJgfRffkRoklIBDIqO/c59ZsvWrB7I0l5CE4V7Iza/Fh5pb0O1ngADT5Bk6ubx6GQ5sXZA3gTKcxbU6NxW5ESK602QrtuHMU4ojdNeQv19EvsAYYNFR2IcX4M7UDydk8pyJH7ViwZ7qKZXC/yW45ydq+C4vhcpXLEZJRKxXcrh3dSyF/QhUbgTyKU7V63zK6QHPB5GSPUulcyCAiKH/do0EDRv3GmSJpQ2XphUHgPnwSKu/tPHN8KKQHpcMnNmHoCDswWQokv3KVfqJMUaDmgM9mpK/OGs8qpBZNX3QdRwlAV575od2YQ/U+MDbNcx2J6IOqdmKA9WX/8//mRlgOKCWpMxUujH7nxqOttyffYN/yIu0hmCU9wLWN+1jk47Ft1nc5uodMHEDlfI1IafdwHNMoIH/s59IsiXc5Uw18Foou+7xbDGnJW1k6BE1gXkcFXupS12NhW534cx6GQI5+c7JfurGd/Fb1M3ORh5oRTMSgkwlVg+Wn70uNNWSD2F7zPLOzJexgkRaYFWhsTsuZqsVTvk6/16S2zl7uuDURrUY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199024)(1800799009)(186009)(6506007)(478600001)(6486002)(86362001)(53546011)(26005)(5660300002)(71200400001)(6512007)(83380400001)(33656002)(122000001)(2906002)(38100700002)(38070700005)(66556008)(36756003)(2616005)(76116006)(316002)(54906003)(66476007)(66446008)(64756008)(66946007)(110136005)(91956017)(8676002)(4326008)(8936002)(41300700001)(45980500001)(1758585002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?740Fqr77XbFR0DKiJ56IAh/f59vb/YuYP8g5AALsJI0sB0SvhyZS38JHl3BI?=
 =?us-ascii?Q?3nqFyXG0VtEXtM4AhRXjdDSKTdCZwo0V3U+GF19lsM5LZTMIradAzkXZggBv?=
 =?us-ascii?Q?jay8WuZ2e53sZmt4qaVOYwIlCmYAt4DeXJk6ljbj9Uy0uZ+FsRLZ5WREmISB?=
 =?us-ascii?Q?1Uomi6QKopE/5GSwMuTD6rQ/QXrREySD/OtsjzX8Xzn+U51oARWHEjZ1CVkd?=
 =?us-ascii?Q?gNSZOqt3b86R5LLnHdDK7XfoWi7kxOQez7zOK4KckvAk74+xKhVPv8rHW29a?=
 =?us-ascii?Q?JNeHZ2tTx0V5vLLKh36cPu77vhKT0v2clByUnm5UC2ZRtkoeXMkoxjuS0gKK?=
 =?us-ascii?Q?lPEhsnyygrguXSTnrCx721U6luYqkFHLjCxHWXv/aeimtnxVmYxeefCnBeeZ?=
 =?us-ascii?Q?CXAcHcvMgpTLb8w4L6Y6y198IVqVaAO0Kbsa317sLVX49fFvFjXjWRakm+W6?=
 =?us-ascii?Q?voI+Q87m+ddBqIMWTXBX2SK9cvh1UFPt8z9WCt0rqgAsWTi6S9zx9FY3ZEyh?=
 =?us-ascii?Q?ZNpUMI/lOJvuHKZ4fzJI9mqMjoalJQEaPjmFYtxPqV/eilAYO5lSKLZSvLnM?=
 =?us-ascii?Q?HYOSyk97OGYpxjOkJ2YBtFiQVF67alJ7f1JxuSE89SbIA4ViTd3+cudv0QMY?=
 =?us-ascii?Q?uC0z356QVV1ZF91yBM2Gaj1veGVRz57jS40n+0dI6rtu8hpk8cAyesMYM/AI?=
 =?us-ascii?Q?g+qmcebNZtLK0NVTjg91ZACU3epkKMK3MWfg5n/OHKtQqLBOCXeCMCWnYYWk?=
 =?us-ascii?Q?B6CdYlE7MFfKtYRwuh8hSbIlVY+pt9epM9EP1t7sC2f540efbZLJJbqMbM37?=
 =?us-ascii?Q?4jtull847A38IvQjg1lr1W6LffI+sDWudcC7El3wzG5RRrZnAzw5qxhnT0ja?=
 =?us-ascii?Q?63hibhGwhY1Yp1EMWGujFhmvxzEDdZ2pFdAwqYAPSChdeKxvt6bUQy80hzD0?=
 =?us-ascii?Q?HYNzU9svnYWxXwJ2tzcXDXmZEh/7yTZsGs+GangjKuY/ZXqk2klYeoLcW3ls?=
 =?us-ascii?Q?OSj/1bqg1AZOaXzorLV8R+MlOL4RTK4sXu5R1hgoXzi7OQ+nCfTWKjQeQrTJ?=
 =?us-ascii?Q?MhHKz03LD21zVtW4fniNPfpVBiyuFQQ9wJgoRGop+CNeMw1NWeL59mX8zt6a?=
 =?us-ascii?Q?4RzuWukC1ikY3ukR5XWL0yCsPJHC1u9jIji87jANXJN6meG1XQ3tIfZUnb+w?=
 =?us-ascii?Q?YzZw1iC9fVkVwDNL2Zldo5hKxewOJkIYbIwzylQsDkIIEiCufhsE+aHNAKgH?=
 =?us-ascii?Q?tblkLSJVGVBw9AKVTgzIK2GPYBSHqRuePl7/CLhHCyhFgWOgJVbK15CZIPxm?=
 =?us-ascii?Q?94OEq0jpUEgjTF78e20CxfCj3qqBOI0kmuuULIIc9QIm6ZS6WrN5HeWEnu3/?=
 =?us-ascii?Q?4BoVbNkmPe4h95Sjxpyeztw0I2FfnQz+l+aALjBrKDflbwsrD45PYAidtuGD?=
 =?us-ascii?Q?Q6ggPKIkEICwwpFI3wMklXG+m6MIpmIIe4CfDKO2qIgA21ED5RXTiC7/IMXY?=
 =?us-ascii?Q?aZiJLdeHATfkvMtwUPrIUum6RZolZqh2vhBebXzN2QpGLMpNFUsW2HH6QXb6?=
 =?us-ascii?Q?Vjw8oU3kEn1mgDJgFsKthVfXA07xkQUqp/d+ybC9Np6uylPC/dixCrcr7N53?=
 =?us-ascii?Q?OQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <56EFCBBD1E60D94CBA36872C4CAF6664@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oLLCFPMVbE02fzc4ENN6QXUQ9bp0kOZ5/7OK+3BY7cD5a+df9qk+VI94DMNdVqmhl8e+Wy+uBAOKpMBpnziBpNvIJ5QrYbjvRJGyeBWJJEkltbY9ZrSCNdaVV2c7zh41cJl/0ZW7gBgMSrrH6sJfQxFExB8H/IkJ0Irt6o9eTJ8yUmCfVhTsCVmBHUoW73q2lNhkYhWzlPHhE+A2Z3PABcYALzmgWhvH71eJviLllDSqr2H2qVg+M0pspmV77NJ45ry6bBXL1H2v1NyhnDCzwg6BcyQswynha3WVIgKSOZmArKBTsT6oGp1BaaLSuwOY++nYXEO7XpT/aQbpDLGlcDkyMxzYFnwzwxA6Sehx8kyL8JYSeYJKv20zMQjiWB90H+EJ7aaDPv8mBDKy+ifzRIflwmdJZcOEdq4rKtmeIrml1L9m/qdxUFqZk/nyUGDwTcdC5vlwkxWsHUagnKlNnski/p5TdNFpORZnRoBSC1XF+tavSPvqgHqNPNsBx9f2GZgvCYPxd4tuhkssH+IbvDc6v207gmcAgvMQMEH2EHdp9aUEd9F1y4YMJqudeXyzFMbcMc4vLs+cdCUhoBMWwXgOIgZ5n1Uww32ooLR/3gV88i2rJzUZZf8p09lHg2KwF/9xemxKKLjO5wtArcoD+g+Cu9Wyd3tRJplGFunufRwc5ZcdE1y/+2xpiUfkaguQ5Z77ggzvqWXbyhR3etaMYvVSPru8ojIC1ya+g/Z2R+xtf/yaC466tF81lYVJNwueKmZ6cWhUk3UfQYZYVphLGduhihyO7lAVBCEDMyZUHoEPx/ctQTuPTTYjxmgWTWWf
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733a3c3b-0b52-4043-7903-08dbafec91b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2023 21:51:19.4671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lus26Gypm+2fCW1EryExMjVZueGoitK8IRw3e9z1t/OywWGVzGjDPbMU9/jaBW3lSmlUFhj1q5a/jEwPJdmukQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-07_13,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=996
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2309070194
X-Proofpoint-GUID: OejEcsoQFeBPXNCliSQs8WzozI-FW27Z
X-Proofpoint-ORIG-GUID: OejEcsoQFeBPXNCliSQs8WzozI-FW27Z
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 7, 2023, at 5:05 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 08 Sep 2023, Chuck Lever III wrote:
>>=20
>>> On Sep 5, 2023, at 11:01 AM, Chuck Lever III <chuck.lever@oracle.com> w=
rote:
>>>=20
>>>> On Sep 5, 2023, at 10:54 AM, Christian Brauner <brauner@kernel.org> wr=
ote:
>>>>=20
>>>> Hey,
>>>>=20
>>>> I just tried to test some changes which had commit
>>>> 99d99825fc07 ("Merge tag 'nfs-for-6.6-1' of git://git.linux-nfs.org/pr=
ojects/anna/linux-nfs")
>>>> as base and when I booted with the appended config I saw a splat right=
 at boot:
>>>>=20
>>>> [   92.804377][ T5306] kernel BUG at net/sunrpc/svc.c:581!
>=20
> The most likely cause for this BUG_ON that I can see is if the
> svc_set_num_threads() call in nfsd_svc() fails.
>=20
> Either some listening sockets had previously been created via
> write_ports(), or they have just been created in nfsd_startup_net().
> ->sv_nrthreads is 0 and this is an attempt to increase that.
> However the thread creation fails - presumably ENOMEM.
> So we goto out_shutdown, stepping right over the nfsd_shutdown_net()
> ca..
> Then the svc_put() calls (probably two, as keep_active was probably
> set).  result in the kref reaching zero and svc_destroy() being called
> even though there are still sockets present (because nfsd_shutdown_net()
> was skipped).
>=20
> I tried
> - error =3D svc_set_num_threads(serv, NULL, nrservs);
> + error =3D -ENOMEM; //svc_set_num_threads(serv, NULL, nrservs);
> if (error)
> goto out_shutdown;
>=20
> and I get exactly the same BUG_ON() as you got.

Christian, can you provide the arguments your system uses for
rpc.nfsd? I'm not sure which distribution you're using, so I
can't provide the exact steps. /etc/nfs.conf is one place to
look.

Neil, do we really need a BUG_ON for this assertion? I'm
considering making it a simple pr_warn(). Interested in
opinions.

Past that, obviously input checking is missing here, so the
error flows in nfsd_svc() need improvement.


> NeilBrown
>=20
>=20
>>>> [   92.811194][ T5306] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
>>>> [   92.821472][ T5306] CPU: 6 PID: 5306 Comm: rpc.nfsd Tainted: G
>>>> [   92.828578][ T5306] Hardware name: QEMU Standard PC (Q35 + ICH9, 20=
09)/LXD, BIOS unknown 2/2/2022
>>>> [   92.836319][ T5306] RIP: 0010:svc_destroy+0x206/0x270
>>>> [   92.852006][ T5306] Code: 72 49 8b bc 24 a0 00 00 00 e8 a6 a3 5e f8=
 48 8b 3c 24 48 83 c4 10 5b 5d 41 5c 41 5d 41 5e 41 5f e9 8f a3 5e f8 e8 aa=
 df 1c f8 <0f> 0b e8 a3 df 1c f8 0f 0b 4c 89 ff e8 39 03 79 f8 e9 ae fe ff =
ff
>>>> [   92.867075][ T5306] RSP: 0018:ffffc9000a347b60 EFLAGS: 00010293
>>>> [   92.872714][ T5306] RAX: 0000000000000000 RBX: ffff88813abf5c68 RCX=
: 0000000000000000
>>>> [   92.884809][ T5306] RDX: ffff888126c38000 RSI: ffffffff896bcf46 RDI=
: 0000000000000005
>>>> [   92.894190][ T5306] RBP: 00000000fffffff4 R08: 0000000000000005 R09=
: 0000000000000000
>>>> [   92.900512][ T5306] R10: 0000000000000000 R11: 0000000000000000 R12=
: ffff88813abf5c50
>>>> [   92.907935][ T5306] R13: ffff88813abf5c50 R14: ffff88813abf5c00 R15=
: ffff8881183c8000
>>>> [   92.917264][ T5306] FS:  00007fabf0bba740(0000) GS:ffff8883a9100000=
(0000) knlGS:0000000000000000
>>>> [   92.924880][ T5306] CS:  0010 DS: 0000 ES: 0000 CR0: 00000000800500=
33
>>>> [   92.930358][ T5306] CR2: 00005568a27d60e8 CR3: 00000001737c3000 CR4=
: 0000000000750ee0
>>>> [   92.937465][ T5306] DR0: 0000000000000000 DR1: 0000000000000000 DR2=
: 0000000000000000
>>>> [   92.943057][ T5306] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7=
: 0000000000000400
>>>> [   92.948673][ T5306] PKRU: 55555554
>>>> [   92.953452][ T5306] Call Trace:
>>>> [   92.958082][ T5306]  <TASK>
>>>> [   92.962546][ T5306]  ? show_regs+0x94/0xa0
>>>> [   92.967221][ T5306]  ? die+0x3b/0xb0
>>>> [   92.971702][ T5306]  ? do_trap+0x231/0x410
>>>> [   92.976275][ T5306]  ? svc_destroy+0x206/0x270
>>>> [   92.980717][ T5306]  ? do_error_trap+0xf9/0x230
>>>> [   92.985287][ T5306]  ? svc_destroy+0x206/0x270
>>>> [   92.989693][ T5306]  ? handle_invalid_op+0x34/0x40
>>>> [   92.994044][ T5306]  ? svc_destroy+0x206/0x270
>>>> [   92.998317][ T5306]  ? exc_invalid_op+0x2d/0x40
>>>> [   93.002503][ T5306]  ? asm_exc_invalid_op+0x1a/0x20
>>>> [   93.006701][ T5306]  ? svc_destroy+0x206/0x270
>>>> [   93.010766][ T5306]  ? svc_destroy+0x206/0x270
>>>> [   93.014727][ T5306]  nfsd_svc+0x6d4/0xac0
>>>> [   93.018510][ T5306]  write_threads+0x296/0x4e0
>>>> [   93.022298][ T5306]  ? write_filehandle+0x760/0x760
>>>> [   93.026072][ T5306]  ? simple_transaction_get+0xf8/0x140
>>>> [   93.029819][ T5306]  ? preempt_count_sub+0x150/0x150
>>>> [   93.033456][ T5306]  ? do_raw_spin_lock+0x133/0x2c0
>>>> [   93.037013][ T5306]  ? _copy_from_user+0x5d/0xf0
>>>> [   93.040385][ T5306]  ? write_filehandle+0x760/0x760
>>>> [   93.043610][ T5306]  nfsctl_transaction_write+0x100/0x180
>>>> [   93.046900][ T5306]  vfs_write+0x2a9/0xe40
>>>> [   93.049930][ T5306]  ? export_features_open+0x60/0x60
>>>> [   93.053124][ T5306]  ? kernel_write+0x6c0/0x6c0
>>>> [   93.056116][ T5306]  ? do_sys_openat2+0xb6/0x1e0
>>>> [   93.059167][ T5306]  ? build_open_flags+0x690/0x690
>>>> [   93.062197][ T5306]  ? __fget_light+0x201/0x270
>>>> [   93.065020][ T5306]  ksys_write+0x134/0x260
>>>> [   93.067775][ T5306]  ? __ia32_sys_read+0xb0/0xb0
>>>> [   93.070501][ T5306]  ? rcu_is_watching+0x12/0xb0
>>>> [   93.073073][ T5306]  ? trace_irq_enable.constprop.0+0xd0/0x100
>>>> [   93.075937][ T5306]  do_syscall_64+0x38/0xb0
>>>> [   93.078394][ T5306]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>>>=20
>>>> I haven't spent time debugging this further. Maybe you see the issue r=
ight
>>>> away.
>>>=20
>>> I don't, unfortunately. A bisect would be appropriate.
>>>=20
>>> I will pull today's master branch and see if I can reproduce.
>>=20
>> I wasn't able to reproduce this with yesterday's master. I don't
>> recall anything in Anna's NFS client PR that might account for
>> this crash.
>>=20
>> Neil, I think you were the last person to touch the code in and
>> around svc_destroy(). Can you have a look at this?
>>=20
>>=20
>>>> This problem is only happening after the nfs merges afaict. I'm
>>>> currently using commit 3ef96fcfd50b ("Merge tag 'ext4_for_linus-6.6-rc=
1'
>>>> of git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4") as base
>>>> and that splat doesn't appear.
>>>>=20
>>>> Hopefully this is not a red herring.
>>>> Christian
>>>> <.config.txt>
>>>=20
>>> --
>>> Chuck Lever
>>=20
>>=20
>> --
>> Chuck Lever
>>=20
>>=20
>>=20
>=20

--
Chuck Lever


