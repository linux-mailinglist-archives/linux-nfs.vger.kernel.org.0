Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECB835E1A8
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Apr 2021 16:36:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344040AbhDMOex (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 13 Apr 2021 10:34:53 -0400
Received: from mail-co1nam11on2103.outbound.protection.outlook.com ([40.107.220.103]:10849
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344555AbhDMOeL (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 13 Apr 2021 10:34:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wcw8/5exDFC7XEZRZ84TpTPajGETDlrKUcnY8Q/b+0xANz4EaOl96WxSuu9uAPwm23/+8bdazklhKqFefXJ5ztCcdtkLIRceeL6HwbDPNiwl7uXPeh0q+/S5Du4eIWsIhIFTCCbGlJyy9uA4SOVvObkd42aC3R17zZasQue/I0m1IGrFDV1ScR8BsnPMk5SEYYJSUk3kMSlUxhAHKRdglTJ15ZthdGH5WBPmK6xUAoLd0aUi56FsSIamugaNbRC8spMKPYIJaK3jJ17zSJLwQ5AAbazWlp+Y0ID/l9+1saG/3g7cXNMxoEBmF9CFXl6SGewStC+n7e4Wuc1D9zgbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLBUJuxNsf/xF/oEjpNU7k7OLMtmPhAFAPV6jIK9CwE=;
 b=fDS7nEEQlj98HAViQzuIotI1Yr/j6U++J+IPbv9se2gjfS30Tuo/jaq6o7wX9syI4VsVBmwnakfOTWfP1Jx6yDx1v6cQMnFPPpNB3hYqE+5GA0zxfL5kO5jp+J8c89eIF3Mvw2LVfsjeSu6oKR5W3YFtKXjdhuC/qWtzcOgU8bUJwEDtequ0eZrfUYTHIKYMhe4rDuZJRxVpq9ozy4xhVH2mVdD71YB4JuOzLwuOAYvw2vUd+nFxhP8/ApaUJi4xJlpQUiHoUeWA4E0szXKs2+h78VZ833JPU196cru/RdGGtXOx0GzT8kxKlNiU6ptK/W5GU4xABiBx+LcaHLmKxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rutgers.edu; dmarc=pass action=none header.from=rutgers.edu;
 dkim=pass header.d=rutgers.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rutgers.edu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLBUJuxNsf/xF/oEjpNU7k7OLMtmPhAFAPV6jIK9CwE=;
 b=gRZRi4k6yyKR9xFahiexDnmuuRk4p9qtBwB8ex7OZDlMjx2yJHljro2TBadoGwnw7eJ3uK4/6wBYzN5KdYYgKz8gOyfsn9pqV2snX81QjSUZl4q7Kjhq8lethqXO4yHUTJ74I1QrXlWBxDaSx+mr/Cc9EeIg0+viqZtKdvYaw5Q=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=rutgers.edu;
Received: from BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7)
 by BL0PR14MB3588.namprd14.prod.outlook.com (2603:10b6:208:1cb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Tue, 13 Apr
 2021 14:33:51 +0000
Received: from BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0]) by BL0PR14MB3588.namprd14.prod.outlook.com
 ([fe80::2848:113d:4d17:51a0%6]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 14:33:50 +0000
From:   hedrick@rutgers.edu
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: safe versions of NFS
Message-Id: <D8F59140-83D4-49F8-A858-D163910F0CA1@rutgers.edu>
Date:   Tue, 13 Apr 2021 10:33:49 -0400
To:     linux-nfs@vger.kernel.org
X-Mailer: Apple Mail (2.3654.40.0.2.32)
X-Originating-IP: [2620:0:d60:ac1a::a]
X-ClientProxiedBy: BL1PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::6) To BL0PR14MB3588.namprd14.prod.outlook.com
 (2603:10b6:208:1cb::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from heidelberg.cs.rutgers.edu (2620:0:d60:ac1a::a) by BL1PR13CA0151.namprd13.prod.outlook.com (2603:10b6:208:2bd::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Tue, 13 Apr 2021 14:33:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 568ed1c5-296f-4a7a-9076-08d8fe8927eb
X-MS-TrafficTypeDiagnostic: BL0PR14MB3588:
X-Microsoft-Antispam-PRVS: <BL0PR14MB3588C43F8218130FBB196781AA4F9@BL0PR14MB3588.namprd14.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ePT4GDVMM0gHI5+x14l5c3kAvW3Be/rFlNur1waLgSvDXdir2RyRdbEF2ltRgYbh8mN/a0YETx/kaUeVIpNBSYNNadqSmCfYgHCk29LodWmi+8RvmpAI6IAh4sRSd8B9KiX1SAt+pjzileqWjb8n+J6sk0q1Icwi4nMoqUeJDPeW3QxvnbWodLJdPJsFZvLb/lWNVg69+d1p+Epz9hU3cUtBCKtgTeDqW2mhB+MwXvJENdkm77sbnIxF5t9tYCC7/67tME/ekob+quF3gRudBvjQ8wrOjXIQhxGF2vFfD7mDUt9LdDoodoGa6ajGc7CSq7pUFCRPUQcqLNCy6rRr0xtUuEoZK3HxIx9HT8am0V2bYfOj60Ypgb6YEojIH0v3SaC/BlJlsK0Plh8bYOFURCi7BIrvVB3NmUQR5wz0TkMMgqshdKbCrLg7zb5iQ663dOWAte2crdVe6aemriV426XmM33XlV1AeK4qmKa/6lJe5lvgah7OBifG1Y2oOrMwUrXBy69Jmu9YLN3T6+9yGilb2kNA5ByooyhENGoLfH8az6CMxr+p+QmMSixPkmAOQeUa2VEpfmotzww1FLt3a2baruUs5HQ4gsNRFjXLLWRcyZT/4W0jqIyqTAht8HYFHUaKzZQPI0KvcjWjzkKhiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR14MB3588.namprd14.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39840400004)(66946007)(9686003)(66556008)(7696005)(52116002)(66476007)(6486002)(6916009)(83380400001)(2616005)(36756003)(3480700007)(8936002)(186003)(16526019)(5660300002)(786003)(38100700002)(4744005)(316002)(8676002)(86362001)(2906002)(33656002)(478600001)(75432002)(2292003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WjVhSHlZODZ3UHdlQWZELzZOa3REdWNldzVwWkxQR2FwdDZoRTd6a2Z0MHE2?=
 =?utf-8?B?M2ZQTnhSTk5qaWZDVXhVMmluZlZFOThXZlM0V1pRbVBiNjdLNi9IL1ladGpr?=
 =?utf-8?B?U2xVNWJiZ3JucnloRXExaDFwS2Z5a04wdFFNdm9zSXlSZXhBa2NES2RXZnlu?=
 =?utf-8?B?Zi8rRElTSXNma2U5M0NIMGhFR2JFYkRtRXNIZFdndDZ2VGREM0xPZDFja29J?=
 =?utf-8?B?eG1Ma3hGTm10N012SHE3MHpYeGQrdWNTTDZoU3lsdGJnUDZXemNMQjFvZ1FJ?=
 =?utf-8?B?czJCVm1IU2pBRFcxSjBkMXVpN25JN0w1ZlkzMzM2SzNmUWQ0bkt3YkVLcjR3?=
 =?utf-8?B?VGw4TWFlK0xLaFVlL2ZIQy9NV2ZtNTRnZVFMamtjZ1FwMThDSXYva2FhU0xh?=
 =?utf-8?B?WTJSb1dDdXBRTng4bWkyQVBSZGxPSmtFaHJ4cS9BZXQwRHhGdkwyRnFCTm45?=
 =?utf-8?B?Y244d2QzUXQ0WEhzS09SUXFmWXJuZ0lYYTRXemhxbDkrdnlMeFNiQXNwQ2w1?=
 =?utf-8?B?Tk9GN3FuaUprSldOclBYUFViSElrOGM3TFVkc3VMbWx4MnhhUHlwVExvVGR5?=
 =?utf-8?B?azdXUWpXV1lnenk2bVRQQmxYdmMyZDFxR1gvbmIzRnVQdVoxcGkyZGxMM3ZO?=
 =?utf-8?B?NUxST2FoK085NGJjQTNpRzMvTDRhSTQ0aXN5SXNLZlBWcmpGNFVoUXVFSzRZ?=
 =?utf-8?B?d2NkZnZBQmxkMmxKd3NHLzRYQmR1Q21aVzA5NXg5SnJZSWVrV2wrZ0E5WkEz?=
 =?utf-8?B?T1NnOFRib2lTRE82Q2QzckJpUmwyUU01N3Y4ck1pV2ZaRUhFcldnZmhlRW5x?=
 =?utf-8?B?MTJ3OGlJNDR3NEhRNm9WTEZIQ0VEdGQxY1AvVnh1L3BkWGkvSzdsL1RpNzdU?=
 =?utf-8?B?NzJqbmNlSlY1VVZib0xaTU14UHRKZm5HUTRmcjdjSjNtclEwc3VVbWVOUExO?=
 =?utf-8?B?MDQyRTYrMElCRlRibDd6MXdIY0wvUFY0QTRvWXRoSW91UGRFOUhBWnRFcHlh?=
 =?utf-8?B?Y1g1NW10NnlaaHc0SytmNkVKMmlidXI1ZDE1bXdGWnpFbjRMUGo5WC92cEIr?=
 =?utf-8?B?WndQaHoxS3l6VmZIOVNYUWpscEtCekRtSjE3bE1lRGhJUTZsY1VueFNWRStM?=
 =?utf-8?B?UWRuOVhaNllwTm1XQ2lyTFYvM1FVVzZkME5MdEN0QTBsREZHTjBOWFVWd0ZY?=
 =?utf-8?B?amNqR2xVTCt4em41b0lwTjFOVzNnazh5ZFNFaHRERzZvb2t0OHBsR1FaRUdY?=
 =?utf-8?B?L1NCMlptMExDUHNVOVU0UnkzY21EYVBYTUZONURHOVhQUVJ0aDB4NnA2cE95?=
 =?utf-8?B?TkxwQzI2NkNCTXZrN1I1MzlpOUcvd3Q1TzVoYVNZK2RmMy9VTmFmK1FrSVBq?=
 =?utf-8?B?ekhUSEcxbHlmUzNFM09NU2xOV1ZBU0lVVXkwL0Y4cXhWbTVXZmJFbWh5ZUxl?=
 =?utf-8?B?QkNDUjVuVVBFdWhvTlRZZXN3SkxSRXhFbVpIekRiNERRQ2dUN2lBTmxwcnp5?=
 =?utf-8?B?bVhxMDdTMW0zeC9Zc2pnaTN0eEJxMWNhMC9hY3BMVkl4dlhZRkNleWFhc25E?=
 =?utf-8?B?R3JWcjMwYkR5RGk4VmVsRTZObzRiV2I3M29iTkR3NGY2eHUyd0xmNW1vVnJS?=
 =?utf-8?B?K3o4WkxlSWJlTENJYkJBUWpSUU16OGNrQ3RpQmpEaXJiY3BYaW8ydzhkc3gr?=
 =?utf-8?B?Wm9ua2hmREdvKzZHQnBSNWhWOE9kb05Ra0Y1SElwR2tTN0hmN2pGS0hmZ2t3?=
 =?utf-8?B?K3ZOVTZXOSs2MDZ1dEU1RjhWbFltVVZLVVZHOGRaZEF3UGZQTzFWRjFtYk1B?=
 =?utf-8?B?eHh1a0RwMjc5SVp6OHZsQT09?=
X-OriginatorOrg: rutgers.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 568ed1c5-296f-4a7a-9076-08d8fe8927eb
X-MS-Exchange-CrossTenant-AuthSource: BL0PR14MB3588.namprd14.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2021 14:33:50.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zhW8z2tDML96QvUoCfGapfABlLec5+j/yK3xjKxnv4AAUmFP1sLbqhfQVwUhAJ/c2OqwCNJP6FEzGbyMLLwLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR14MB3588
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I am in charge of a large computer science dept computing infrastructure. W=
e have a variety of student and develo9pment users. If there are problems w=
e=E2=80=99ll see them.

We use an Ubuntu 20 server, with NVMe storage.

I=E2=80=99ve just had to move Centos 7 and Ubuntu 18 to use NFS 4.0. We had=
 hangs with NFS 4.1 and 4.2. Files would appear to be locked, although even=
tually the lock would time out. It=E2=80=99s too soon to be sure that movin=
g back to NFS 4.0 will fix it. Next is either NFS 3 or disabling delegation=
s on the server.

Are there known versions of NFS that are safe to use in production for vari=
ous kernel versions? The one we=E2=80=99re most interested in is Ubuntu 20,=
 which can be anything from 5.4 to 5.8.


