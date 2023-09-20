Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFDE7A8FC6
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Sep 2023 01:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229468AbjITXOY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 Sep 2023 19:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjITXOX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 Sep 2023 19:14:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2092.outbound.protection.outlook.com [40.107.94.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE73C9
        for <linux-nfs@vger.kernel.org>; Wed, 20 Sep 2023 16:14:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jn70AXr/r/jrcUdy41BX5x1OP2uL7WUbF4i41pLIitGpK4enHsbr5CQdHOGFVb9LpAboFXq/MbuN11/a2TpXo8CKVsqaAtN2jf+PR9kdqA7HFbbJU/04ANQvUkfukJU3iy9M60cGyiB/poFilw5z+FQqWAkARA68EfaG6ARjfstVe6DKy8pNh74nhkk9wef86St0Wfc7CVpGJt2Vvpq8DmNfDmkYLfNufmsJL+x4gjEe7ODHwo0jotEIwaPWF8wY/uU6nZG43oIfhiRhy+X1HsLi76xR5PX6yxu03p2MEFrT/syaEa4rHTMX8hZ4z1UpnY+a5zLotUyeWdmrYF7WXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm+iRrZyLAwGUjWakKdrWbI0Pw/2bSIzd4n4dAqZAfA=;
 b=JBiLFa1R0tUbJRCiQP7qBChZSwVaGrEy+Yk0nLuTm2UwqlaId+acgt1HhvSexptyWSRBZxyUiXQeCtjUJzZ/LHukdbRpeulBNji1O3MfR8lMzEdx5KiPtUV1ajWZoR0YXm75lrDb5s3vmi1PnBU0mfLCO1zaIuAjvG7UM9aDGwA1VHR8ovs/2oZhiw2Hr9X2hTNmb+5xlCKVLoI5fx0Lf/QvOpfPd7XAtdMWdUGnBsG/KYKvtXdaoq+EfQwc4fNJIrzR+hL8PaLnrNI5lImwiySgTDk9uQKQq5UXrbYbYlNRKnFaSdj8GUx1JMcZIj/U2eRyT7uG9VfS+nl/r7PT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm+iRrZyLAwGUjWakKdrWbI0Pw/2bSIzd4n4dAqZAfA=;
 b=kIM1XsM1e8xbFgKviKXH/U27mGJY0+CbWRhK1xq0mWLwdCtw8wrpjMn0Nj3t5ovq4rwojuOGCKdlrmoPXAPv2r6Vw28AYcabK0e8d4CQBTiKSqz+c+qtoB4Ddx7Ye9mihFS9C6pQ0GYKZTikhkuIltIH+e164eyN65A+FN6wPzw=
Received: from PH0PR14MB5493.namprd14.prod.outlook.com (2603:10b6:510:12a::11)
 by BY1PR14MB7029.namprd14.prod.outlook.com (2603:10b6:a03:523::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Wed, 20 Sep
 2023 23:14:15 +0000
Received: from PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6a50:ce96:4b7:a145]) by PH0PR14MB5493.namprd14.prod.outlook.com
 ([fe80::6a50:ce96:4b7:a145%5]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 23:14:15 +0000
From:   Charles Hedrick <hedrick@rutgers.edu>
To:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: bad info in NFS context
Thread-Topic: bad info in NFS context
Thread-Index: AQHZ7Bgh+wAiuciHp0i2Q0AWGe3SvQ==
Date:   Wed, 20 Sep 2023 23:14:15 +0000
Message-ID: <PH0PR14MB5493ED33985C95FEBE4DA808AAF9A@PH0PR14MB5493.namprd14.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rutgers.edu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR14MB5493:EE_|BY1PR14MB7029:EE_
x-ms-office365-filtering-correlation-id: b2e696e0-6b0e-4166-bc89-08dbba2f4f25
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MSZE+nwShVRfdrSmBwGhwQPQyL69p8cjina040i1QEDNU/rGkh/1et4ClHYWIWIOvVLd5x19fQYlFyB6vplRyGODEVS9rOBp0ch/TaEOjO9nuWXosG61/F2jtDMPIVAJfHFzOITNdaTMlSm9+I5rAL0dzu0eYyrq9XBu1x00JWUjD40PUs/t+yxvyPOva47Y53/G4E0FhWtW1+vNtQa02LAnLhte80CcVaNX5bLAQLpvTr+dJShCikbpvlTXiMK7WvJBIhpP1kbXFOi62VIyNlq+DtMjNx3H+7xcUfOjMOmRKLUqoZXVUCuyhUZeTBmv5Q6siSXh4Sn8YjkZamWyY8FR5jTNSeJq67OfyUkDy+GTztBzpY3gM4nCWZ1U4eGZ2vJHvv+3hGhwwUYRrbJ9GWgNLFCYlkVwBpNhpsknfWWURa6wOylYI45hvcvCmUfweXabMF1y4s8LjmCenMxw2z8DdCAnPq6NoAgX94PgFmiVnOiv+N0LJxGnsPAxB78UcJmMh7dV2PlDFg664CAiZhLpca9R1SwWeUj5q7bMVlK7ooD30il5WUBuvGNfllBNn4U57H1VKxPFju/XmGdBePVeyXZWVKYjc/W6LZQcI+i0+suWScFqn/rJm0KOqszO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR14MB5493.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(346002)(136003)(1800799009)(186009)(451199024)(478600001)(9686003)(6506007)(7696005)(8676002)(8936002)(52536014)(66946007)(66476007)(64756008)(66446008)(66556008)(76116006)(71200400001)(786003)(6916009)(91956017)(316002)(5660300002)(55016003)(75432002)(33656002)(38100700002)(38070700005)(86362001)(26005)(2906002)(4744005)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NXsc8IFDHOSjrR1ijy48LKgd/lZaZ21G9a6rGekl5IoZqbzDOsZvla/9SH?=
 =?iso-8859-1?Q?rQ8VSB3YGkPMUm0mnjNlVy9nqR+3xhrVfojMtPg6q8mOX4l8O5V3aoCJ8P?=
 =?iso-8859-1?Q?7+zOvXqW7m1rQZcwr3qtkdgfIgRjoYBCHVOHhcdTFtowoJslSbflwrEqwI?=
 =?iso-8859-1?Q?XKi+nhvwJFLRsC3m/ua9vNkKu+YEqQGGFcAst+1wg0RN/UI7jyXqnhSOVW?=
 =?iso-8859-1?Q?tIK66eYEeeduaw/Mwqr0C238bnZ9JhPBatPivH5iFJkizik5fTLsSzUxTJ?=
 =?iso-8859-1?Q?EhLS4RsQIuNTJVg+rb/ZJvpEyQlMj4zTKLnjgmAUM6B/6LJ2n8HXnDVMcZ?=
 =?iso-8859-1?Q?5ELyitzLnlKpyIgUlcjlTi2OjBLNPOAJb+PnL1+kSu0djeUIODcfbSFybW?=
 =?iso-8859-1?Q?/dL8Vp1MJ2fRinzTIbU+bqSBK/6RjedQv01Jq3StfDjIjz4JdOICy8sX7J?=
 =?iso-8859-1?Q?dcsuzuJ6XXxweWj/gVmmsdOQyTs0Vuvt5rOeo+YYzLExNhJEZAiFbiHmx8?=
 =?iso-8859-1?Q?7Zk0h2s2nZHEQew9tFEzwqUKK4zSfDBd0lTqcqSShV4+sm12QfbhzRJOB0?=
 =?iso-8859-1?Q?rdkV89eSSQ+OVr1OdDJDagRHaXKVlPMQfCD1BDl2ClywQ98RPZv2QoDkPs?=
 =?iso-8859-1?Q?e9pG1IYjMXSb5W4qCwKvzbiXZjjwoIQtQSY61Pt+59dSys7J2f515GI/aI?=
 =?iso-8859-1?Q?BxqgfmA78TFLUDoq3GRGiObOEacA5ge1OySlU2L8ijrQwqlt9oYZBfCpUB?=
 =?iso-8859-1?Q?6P+yfDCJ7eGIumQiqJjYXuJymBvdCWOBQHBUqfFiX1KhudJQY/87KAYudT?=
 =?iso-8859-1?Q?iZGAXhnmTsmP62+4zjUcyjCQaFmeotXZFfXdjDMEJQhNUgXFEyEmJPjBjc?=
 =?iso-8859-1?Q?Pj0kx90hHKc8PZyOBpTuXeIxMJbCGko5UnlMMYPu9o9o/OhwnPm04PLPH5?=
 =?iso-8859-1?Q?d0oqW5lwiEq3OQsFzlXT8WToZOt/phOIhxstdBEHO3tNbDawe1i7SnQXwn?=
 =?iso-8859-1?Q?NBbARTvsJ+FMs/ruJGOrj6efqy1goO3ZG6X7xD9tr1UgCTOc4LMkpdmDJx?=
 =?iso-8859-1?Q?VqYXtPZHl44V52ywqfk5HMAPNSpEhR4NhVLe8nLqgrx9/z/ouxyXA+YCrY?=
 =?iso-8859-1?Q?UW2JCNXW1qoXzSEPExFG1e5Stwlzp6+36rPQMoi99MHiFxniBG0PFsoS+I?=
 =?iso-8859-1?Q?Y3+NQJ2r9hP90kw6xK9f3lTUMVyOBvG7acjjCWQPs+YMudJf5UY4rjuSm2?=
 =?iso-8859-1?Q?dV2mbrmgECskGaOHY+O03Bh2CsM2YpbpT44GGg7GauU0u3tKkZ8anSwon+?=
 =?iso-8859-1?Q?cfr/gC7rMg/bk4RsGOfWkNuVfOjsLePXPDLCP9IIuOJQCITPB2gQuq1Y6O?=
 =?iso-8859-1?Q?Y3h3VKs7FkhQnaET+rnHPWjDohrmxmgyxSqIt7xsK9PU0jaNFT04FlDQF+?=
 =?iso-8859-1?Q?HX8uhc3V75J6KprP723Ai1MDfccHbz7H2RYviJGjDYA1rHD1jDf75ZiTuY?=
 =?iso-8859-1?Q?P9vC/9JuMn2PVhQ9I0F2HHPQgNGXMZB/3DCBguGHT6GRkvopMvPx8piqkO?=
 =?iso-8859-1?Q?EsZik/26nu7KHsxw6wLU7U3lJ2etD9jTOC+AojcDV73pHI8ENhi86+PiGN?=
 =?iso-8859-1?Q?NeK3stdApjhUEZvxLpc3YuiqUpQcPeyKLk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR14MB5493.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e696e0-6b0e-4166-bc89-08dbba2f4f25
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 23:14:15.6708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fYoKmk31+ufsYvXz+gI+RlSFSn7ErwosOGgArwJdeMWZHOtrgMUTdfD5He3Ns6ZEflY898k1grCCFN/xhVx3ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR14MB7029
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Ubuntu 22 client and server (5.15). Mount is 4.2, sec=3Dsys. I add a user t=
o a group, but they can't see things that the group should be able to see. =
/proc/net/rpc/auth.unix.gid/content shows that the nfs group cache has thei=
r group membership. Doing a mount -o vers=3D4.1 works (4.1 to force a diffe=
rent context). Other users that didn't try before work. It's been several h=
ours, and 4.2 still won't work for this user.=0A=
=0A=
What do I need to flush?=0A=
=0A=
Note that I'm using gssproxy on the server.=0A=
=0A=
